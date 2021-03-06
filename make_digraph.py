from visualization import convert_automaton_to_graphviz
from smt_tools import translate_smtformula_to_human_readable
from argparse import ArgumentParser
import parse
import sys
import logging
from log import logger
import html


arg_parser = ArgumentParser()
arg_parser.add_argument('-i',
                        '--input-file',
                        help='Read from file instead of stdin',
                        dest='file_input',
                        type=str,
                        default=None)

arg_parser.add_argument('-d',
                        '--domain',
                        choices=['naturals', 'integers'],
                        help='Choose in which domain should the solution lie',
                        dest='domain',
                        type=str,
                        default='integers')

arg_parser.add_argument('-v',
                        '--verbose',
                        help='Prints parser status/progress messages',
                        default=False,
                        action='store_true'
                        )


arg_parser.add_argument('-p',
                        '--purge-nonfinishing',
                        help='After the final automaton is build, remove states which cannot lead to any final state',
                        dest='purge_nonfinishing',
                        default=False,
                        action='store_true'
                        )


args = arg_parser.parse_args()

if args.verbose:
    logger.setLevel(logging.INFO)
else:
    logger.setLevel(logging.CRITICAL)


def export_dot_from_stmlibsrc(smtlib_src: str) -> str:
    logger.info('Parsing source.')
    tokens = parse.lex(smtlib_src)
    logger.info('Building AST.')
    expr_tree = parse.build_syntax_tree(tokens)

    asserts = parse.get_asserts_from_ast(expr_tree)
    logger.info(f'Extracted {len(asserts)} assert statement(s).')
    if len(asserts) > 1:
        logger.info('Selecting the first one.')

    logger.info('Extracted following assert tree:')
    parse.pretty_print_smt_tree(asserts[0], printer=logger.info)
    automaton_label = html.escape(translate_smtformula_to_human_readable(asserts[0][1]))

    logger.info('Running evaluation phase.')

    if args.domain == 'naturals':
        domain = parse.SolutionDomain.NATURALS
    else:
        domain = parse.SolutionDomain.INTEGERS

    nfa = parse.eval_assert_tree(asserts[0], domain=domain)

    if args.purge_nonfinishing:
        nfa.remove_nonfinishing_states()

    logger.info('Converting NFA to graphviz.')
    return convert_automaton_to_graphviz(nfa, automaton_label)


if args.file_input:
    with open(args.file_input) as input_file:
        smtlib_src = input_file.read()
else:
    smtlib_src = sys.stdin.read()

print(export_dot_from_stmlibsrc(smtlib_src))
