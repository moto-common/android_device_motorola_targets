import argparse

def check_disallowed_terms(input_file, disallowed_terms_file):
    """Check input text file against a list of disallowed terms and report the found terms with line numbers and positions."""
    found_terms = []
    with open(input_file, 'r') as input_file:
        input_lines = input_file.readlines()
        with open(disallowed_terms_file, 'r') as terms_file:
            disallowed_terms = terms_file.read().lower().splitlines()
            for line_num, line in enumerate(input_lines, 1):
                line = line.lower()
                for term in disallowed_terms:
                    term_len = len(term)
                    start_pos = line.find(term)
                    while start_pos != -1:
                        end_pos = start_pos + term_len
                        found_terms.append((term, line_num, start_pos, end_pos))
                        start_pos = line.find(term, start_pos + 1)
    return found_terms

# Create an ArgumentParser
parser = argparse.ArgumentParser(description='Check input text file against a list of disallowed terms.')

# Add input file argument
parser.add_argument('input_file', type=str, help='Path to the input text file to check against disallowed terms.')

# Add disallowed terms file argument
parser.add_argument('disallowed_terms_file', type=str, help='Path to the file containing disallowed terms.')

# Parse command-line arguments
args = parser.parse_args()

# Call the function to check disallowed terms
found_terms = check_disallowed_terms(args.input_file, args.disallowed_terms_file)

if found_terms:
    print("Found disallowed terms:")
    for term, line_num, start_pos, end_pos in found_terms:
        print(f"- Term: '{term}', Line: {line_num}, Start Position: {start_pos}, End Position: {end_pos}")
else:
    print("No disallowed terms found.")