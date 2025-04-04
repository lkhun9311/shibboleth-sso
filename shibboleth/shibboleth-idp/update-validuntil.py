#!/usr/bin/env python3

import xml.etree.ElementTree as ET
from datetime import datetime, timedelta, timezone
import sys
import subprocess

FILE = "/opt/shibboleth-idp/metadata/idp-metadata.xml"
THRESHOLD_DAYS = 7
EXTEND_DAYS = 7

# Parse XML
try:
    tree = ET.parse(FILE)
    root = tree.getroot()
except FileNotFoundError:
    print(f"[ERROR] File Not Found: {FILE}")
    sys.exit(1)
except ET.ParseError as e:
    print(f"[ERROR] XML Parsing Failed: {e}")
    sys.exit(1)
except Exception as e:
    print(f"[ERROR] Unknown Exception Occurred: {e}")
    sys.exit(1)

entity = root

# Get current validUntil
valid_until_str = entity.get("validUntil")
valid_until = datetime.strptime(valid_until_str, "%Y-%m-%dT%H:%M:%S.%fZ").replace(tzinfo=timezone.utc)

# Current time
now = datetime.now(timezone.utc)
diff_days = (valid_until - now).days

# Check threshold
if diff_days <= THRESHOLD_DAYS:
    new_valid_until = now + timedelta(days=EXTEND_DAYS)
    new_valid_until_str = new_valid_until.strftime("%Y-%m-%dT%H:%M:%S.%f")[:-3] + "Z"
    print(f"Updating validUntil: {valid_until_str} -> {new_valid_until_str}")
    entity.set("validUntil", new_valid_until_str)
    tree.write(FILE, encoding="UTF-8", xml_declaration=True)

else:
    print(f"No update needed. validUntil is still {diff_days} days away.")