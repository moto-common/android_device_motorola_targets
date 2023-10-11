import argparse, sys, os, json
import xml.etree.ElementTree as ET

# parse arguments
parser = argparse.ArgumentParser(description='Verifies moto-common.xml against github.com/moto-common')
parser.add_argument('moto_common_xml', metavar='moto_common.xml', help='Path to Moto-Common manifest XML')
args = parser.parse_args()

try:
    with open(args.moto_common_xml, 'r') as f:
        # Parse Moto-Common XML file to get all the names
        tree = ET.parse(f)
        root = tree.getroot()
        names_and_branches = {}
        for i in root.findall('project'):
            names_and_branches.update({i.get('name'): i.get('revision')})
        names_and_branches_keys = list(names_and_branches.keys())
        list_of_repos = json.loads(os.popen('gh repo list moto-common -L 999 --public --json name,defaultBranchRef').read())
        for repo in list_of_repos:
            if repo['name'] in names_and_branches_keys and "moto-common" in repo['name']:
                if names_and_branches[repo['name']] != repo['defaultBranchRef']['name']:
                    print(f"Branch {repo['defaultBranchRef']['name']} is the default instead of {names_and_branches[repo['name']]} for {repo['name']}, please update moto_common.xml or the default branch on GitHub")
                    sys.exit(1)
        print("All branches are in sync!")
except FileNotFoundError:
    print(f"File {args.moto_common_xml} not found!")
    sys.exit(1)
