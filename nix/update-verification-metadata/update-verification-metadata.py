import sys
import xml.etree.ElementTree as ET

verification_file = sys.argv[1]
whitelist = sys.argv[1:]
whitelist_set = set(tuple(item.split(':')) for item in whitelist)

namespaces={'': "https://schema.gradle.org/dependency-verification"}
ET.register_namespace("", namespaces[''])

tree = ET.parse(verification_file)

root = tree.getroot()
components = root.find('components', namespaces)
if (components is not None):
  for component in list(components):
        group = component.get('group')
        name = component.get('name')
        version = component.get('version')
        if (group, name, version) not in whitelist_set:
            components.remove(component)

tree.write(verification_file, encoding='UTF-8', xml_declaration=True)
