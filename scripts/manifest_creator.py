import argparse
import xml.etree.ElementTree as ET

# parse arguments
parser = argparse.ArgumentParser(description='Remove duplicates from a repo manifest file')
parser.add_argument('manifest1', help='Path to ROM manifest XML')
parser.add_argument('manifest2', help='Path to Moto-Common manifest XML')
parser.add_argument('output', help='path to output manifest file')
parser.add_argument('--removal-keywords', nargs='+', default=["st-hal"],
                    help='keywords to match for removal duplicates')
parser.add_argument('--replacement-keywords', nargs='+', default=["qcom-caf/common"],
                    help='keywords to match for replacement duplicates')
parser.add_argument('--remote-name', default='moto-common',
                    help='name of the remote to be added at the beginning of the output manifest')
parser.add_argument('--remote-url', default='https://github.com/moto-common/',
                    help='url of the remote to be added at the beginning of the output manifest')

args = parser.parse_args()

# parse xml files
tree1 = ET.parse(args.manifest1)
root1 = tree1.getroot()

tree2 = ET.parse(args.manifest2)
root2 = tree2.getroot()

# Get the list of paths in the second manifest
paths2 = [project.get('path') for project in root2.findall('project')]

# Define the list of keywords for replacements and removals
replacements_keywords = ['qcom-caf/common']
removals_keywords = ['st-hal']

# Create the new_root, manifest
new_root = ET.Element('manifest')

# Define the moto-common remote
remote = ET.Element('remote', {'name': 'moto-common', 'fetch': 'https://github.com/moto-common/'})
new_root.append(remote)

# Find duplicates and replacements in the first manifest
duplicates = {}
replacements = {}
for project in root1.findall('project'):
    path = project.get('path')
    name = project.get('name')
    linkfile_elems = project.findall('linkfile')
    if path in paths2:
        if path not in duplicates:
            duplicates[path] = [name]
        else:
            duplicates[path].append(name)
    else:
        for keyword in replacements_keywords:
            if keyword in path:
                if path not in replacements:
                    replacements[path] = {'name': name, 'linkfiles': linkfile_elems}
                else:
                    # Only replace with the shortest path match
                    if len(path) < len(replacements[path]['path']):
                        replacements[path] = {'name': name, 'linkfiles': linkfile_elems}
        for keyword in removals_keywords:
            if keyword in path:
                remove = ET.Element('remove-project')
                remove.set('name', name)
                new_root.append(remove)
                break

# Create a new manifest with remove-project and project elements
projects = []
for project in root1.findall('project'):
    path = project.get('path')
    name = project.get('name')
    if path in duplicates and name in duplicates[path]:
        remove = ET.Element('remove-project')
        remove.set('name', name)
        new_root.append(remove)
    elif path in replacements:
        new_project = ET.Element('project')
        new_project.set('path', path)
        new_project.set('name', replacements[path]['name'])
        for linkfile_elem in replacements[path]['linkfiles']:
            new_project.append(linkfile_elem)
        projects.append(new_project)

# Add the remove-project elements at the end of the new manifest
for project in sorted(root1.findall('remove-project') + projects, key=lambda elem: elem.tag): 
    new_root.append(project)

ET.indent(new_root, '  ')
# Write the new manifest to a file
ET.ElementTree(new_root).write(args.output, xml_declaration=True, encoding='UTF-8', method='xml', short_empty_elements=True)
