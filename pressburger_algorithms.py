from __future__ import annotations
from typing import (
    List,
    Tuple,
    Union,
    Set
)
from log import logger
from utils import vector_dot
from automatons import (
    DFA,
    NFA,
    LSBF_Alphabet,
    AutomatonType,
    AutomatonState
)
from relations_structures import Relation
import math


DFA_AlphabetSymbolType = Tuple[int, ...]
DFA_AutomatonStateType = int
NFA_AutomatonStateType = Union[int, str]
NFA_AlphabetSymbolType = Tuple[int, ...]


def add_trap_state_to_automaton(automaton: NFA, trap_state_name='TRAP'):
    automaton.add_state(trap_state_name)
    universal_symbol = tuple(['*' for v in automaton.alphabet.variable_names])
    automaton.update_transition_fn(trap_state_name, universal_symbol, trap_state_name)


def build_dfa_from_inequality(ineq: Relation) -> DFA:
    '''Builds DFA with Lang same as solutions to the inequation over N'''
    logger.debug(f'Building DFA (over N) to inequation: {ineq}')

    alphabet = LSBF_Alphabet.from_inequation(ineq)
    dfa: DFA[DFA_AutomatonStateType] = DFA(
        alphabet=alphabet,
        automaton_type=AutomatonType.DFA
    )
    dfa.add_initial_state(ineq.absolute_part)

    work_queue: List[DFA_AutomatonStateType] = [ineq.absolute_part]

    logger.info(f'Generated alphabet for automaton: {alphabet}')

    while work_queue:
        currently_processed_state = work_queue.pop()
        dfa.add_state(currently_processed_state)

        # Check whether current state satisfies property that it accepts an
        # empty word
        if currently_processed_state >= 0:
            dfa.add_final_state(currently_processed_state)

        for alphabet_symbol in alphabet.symbols:
            # @Optimize: Precompute dot before graph traversal
            dot = vector_dot(alphabet_symbol, ineq.variable_coeficients)
            next_state = math.floor(0.5 * (currently_processed_state - dot))

            # Add newly discovered transition
            dfa.update_transition_fn(currently_processed_state, alphabet_symbol, next_state)

            if not dfa.has_state_with_value(next_state):
                if next_state not in work_queue:
                    work_queue.append(next_state)

    logger.debug(f'Extracted dfa: {dfa}')

    return dfa


def build_dfa_from_equality(eq: Relation) -> DFA:
    alphabet = LSBF_Alphabet.from_inequation(eq)
    dfa: DFA[DFA_AutomatonStateType] = DFA(
        alphabet=alphabet,
        automaton_type=AutomatonType.DFA
    )
    dfa.add_initial_state(eq.absolute_part)
    work_queue: List[DFA_AutomatonStateType] = [eq.absolute_part]

    while work_queue:
        currently_processed_state = work_queue.pop()
        dfa.add_state(currently_processed_state)

        # Check whether current state satisfies property that it accepts an
        # empty word
        if currently_processed_state == 0:
            dfa.add_final_state(currently_processed_state)

        for alphabet_symbol in alphabet.symbols:
            dot = vector_dot(alphabet_symbol, eq.variable_coeficients)
            next_value = currently_processed_state - dot

            if next_value % 2 == 0:
                next_state = int(next_value/2)

                # Add newly discovered transition
                dfa.update_transition_fn(currently_processed_state, alphabet_symbol, next_state)

                if not dfa.has_state_with_value(next_state):
                    if next_state not in work_queue:
                        work_queue.append(next_state)
            else:
                trap_state = 'TRAP'
                if not dfa.has_state_with_value(trap_state):
                    add_trap_state_to_automaton(dfa, trap_state_name=trap_state)
                dfa.update_transition_fn(currently_processed_state, alphabet_symbol, trap_state)

    return dfa


def build_dfa_from_sharp_inequality(ineq: Relation) -> DFA:
    alphabet = LSBF_Alphabet.from_inequation(ineq)
    dfa: DFA[NFA_AutomatonStateType] = DFA(
        alphabet=alphabet,
        automaton_type=AutomatonType.DFA,
    )
    dfa.add_initial_state(ineq.absolute_part)

    work_queue: List[int] = [ineq.absolute_part]

    while work_queue:
        current_state = work_queue.pop()
        dfa.add_state(current_state)

        if current_state > 0:
            dfa.add_final_state(current_state)

        for alphabet_symbol in alphabet.symbols:
            dot = vector_dot(alphabet_symbol, ineq.variable_coeficients)
            next_value = current_state - dot

            destination_state = math.floor(0.5 * next_value)

            if not dfa.has_state_with_value(destination_state):
                work_queue.append(destination_state)

            dfa.update_transition_fn(current_state, alphabet_symbol, destination_state)

    return dfa


def build_nfa_from_inequality(ineq: Relation) -> NFA[NFA_AutomatonStateType]:
    alphabet = LSBF_Alphabet.from_inequation(ineq)
    nfa: NFA[NFA_AutomatonStateType] = NFA(
        alphabet=alphabet,
        automaton_type=AutomatonType.NFA,
    )
    nfa.add_initial_state(ineq.absolute_part)

    work_queue: List[int] = [ineq.absolute_part]

    while work_queue:
        current_state = work_queue.pop()
        nfa.add_state(current_state)

        for alphabet_symbol in alphabet.symbols:
            dot = vector_dot(alphabet_symbol, ineq.variable_coeficients)
            destination_state = math.floor(0.5 * (current_state - dot))

            if not nfa.has_state_with_value(destination_state):
                work_queue.append(destination_state)

            nfa.update_transition_fn(current_state, alphabet_symbol, destination_state)

            # Check whether state is final
            if current_state + dot >= 0:
                final_state = 'FINAL'
                nfa.add_state(final_state)
                nfa.add_final_state(final_state)
                nfa.update_transition_fn(current_state, alphabet_symbol, final_state)

    return nfa


def build_nfa_from_equality(eq: Relation):
    alphabet = LSBF_Alphabet.from_inequation(eq)

    nfa: NFA[NFA_AutomatonStateType] = NFA(
        alphabet=alphabet,
        automaton_type=AutomatonType.NFA
    )

    nfa.add_initial_state(eq.absolute_part)

    states_to_explore: List[int] = [eq.absolute_part]

    while states_to_explore:
        e_state = states_to_explore.pop()
        nfa.add_state(e_state)

        for symbol in alphabet.symbols:
            dot = vector_dot(symbol, eq.variable_coeficients)
            d_state = e_state - dot  # Discovered state

            # Process only even states
            if d_state % 2 == 0:
                d_state = int(d_state / 2)
                nfa.update_transition_fn(e_state, symbol, d_state)

                # Check whether we already did process this state
                if not nfa.has_state_with_value(d_state):
                    # State might be reachable from multiple locations, this
                    # discovery does not have to be the first one
                    if d_state not in states_to_explore:
                        states_to_explore.append(d_state)

                # Check whether current state should have transition to final
                if e_state + dot == 0:
                    nfa.add_state('FINAL')
                    nfa.add_final_state('FINAL')
                    nfa.update_transition_fn(e_state, symbol, 'FINAL')

    return nfa


def create_and_link_prefinal_state(automaton: NFA,
                                   current_state: int,
                                   self_loop_set: Set[Tuple[int, ...]],
                                   final_set: Set[Tuple[int, ...]],
                                   final_state: str):

    prefinal_state = f'{current_state}\'prefinal'
    automaton.add_state(prefinal_state)

    # Link current_state and prefinal
    for symbol in (self_loop_set - final_set):
        automaton.update_transition_fn(current_state, symbol, prefinal_state)

    # Create selfloop
    for self_loop_symbol in self_loop_set:
        automaton.update_transition_fn(prefinal_state, self_loop_symbol, prefinal_state)

    # Link prefinal and final
    for fin_symbol in final_set:
        automaton.update_transition_fn(prefinal_state, fin_symbol, final_state)


def build_nfa_from_sharp_inequality(ineq: Relation, emit_handle=None):
    nfa_eq = build_nfa_from_equality(ineq)
    nfa_neq = nfa_eq.complement()
    nfa_ineq = build_nfa_from_inequality(ineq)

    result = nfa_neq.intersection(nfa_ineq)
    result.remove_nonfinishing_states()
    return result


def build_nfa_from_sharp_inequality2(s_ineq: Relation):
    alphabet = LSBF_Alphabet.from_inequation(s_ineq)
    nfa: NFA[NFA_AutomatonStateType] = NFA(
        alphabet=alphabet,
        automaton_type=AutomatonType.NFA,
    )
    nfa.add_initial_state(s_ineq.absolute_part)

    work_queue: List[int] = [s_ineq.absolute_part]

    while work_queue:
        current_state = work_queue.pop()
        nfa.add_state(current_state)

        final_symbols = []
        self_loop_symbols = []

        for alphabet_symbol in alphabet.symbols:
            dot = vector_dot(alphabet_symbol, s_ineq.variable_coeficients)
            destination_state = math.floor(0.5 * (current_state - dot))

            if not nfa.has_state_with_value(destination_state):
                work_queue.append(destination_state)

            nfa.update_transition_fn(current_state, alphabet_symbol, destination_state)
            if current_state == destination_state:
                self_loop_symbols.append(alphabet_symbol)

            if current_state + dot >= 0:
                # We need to wait till every alphabet symbol has beed explored
                final_symbols.append(alphabet_symbol)

        if final_symbols:
            # We know that a symbol which is leads to final state and also is
            # self loop, would be present also in equation with exact same
            # structure
            final_set = set(final_symbols)
            self_loop_set = set(self_loop_symbols)
            eq_set = final_set.intersection(self_loop_set)
            final_state = None

            if self_loop_set - final_set:
                final_state = 'FINAL'
                nfa.add_state(final_state)
                nfa.add_final_state(final_state)

            # All symbols did lead to final, without selfloop
            # So there is no such symbol which would be accepted by =
            if not eq_set:
                final_state = 'FINAL'
                for symbol in final_set:
                    nfa.update_transition_fn(current_state, symbol, final_state)
            else:
                # Otherwise we wanna take only symbols different from those
                # accepted by =

                # There needs to be at least one such symbol (because all
                # might have been =
                if final_state is not None:
                    create_and_link_prefinal_state(nfa,
                                                   current_state,
                                                   self_loop_set,
                                                   final_set,
                                                   final_state)
    return nfa