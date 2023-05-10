import argparse
import xml.etree.ElementTree as ET

def sort_hal_components(input_file, output_file):
    # Parse the input file
    tree = ET.parse(input_file)
    root = tree.getroot()

    # Find all the HAL components and sort them by name
    hal_components = root.findall('./hal')
    hal_components.sort(key=lambda x: x.find('name').text)

    # Remove the existing HAL components from the tree
    for hal_component in root.findall('./hal'):
        root.remove(hal_component)

    # Add the sorted HAL components back to the tree
    for hal_component in hal_components:
        root.append(hal_component)

    # Write the sorted output to the output file
    with open(output_file, 'w') as f:
        # Write the root element and its children with adjusted indentation
        f.write('<compatibility-matrix version="1.0" type="framework">\n')
        for child in root:
            f.write('    ' + ET.tostring(child, encoding='unicode').strip() + '\n')
        f.write('</compatibility-matrix>\n')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Sort HAL components in a Vintf manifest XML file.')
    parser.add_argument('input_file', help='the input Vintf manifest XML file')
    parser.add_argument('output_file', help='the output Vintf manifest XML file')
    args = parser.parse_args()

    sort_hal_components(args.input_file, args.output_file)

