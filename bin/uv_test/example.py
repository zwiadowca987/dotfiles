# /// script
# requires-python = ">=3.14"
# dependencies = [
#     "requests<3",
#     "rich>=15.0.0",
# ]
# ///


import requests
from rich.pretty import pprint

resp = requests.get("https://peps.python.org/api/peps.json")
data = resp.json()
pprint([(k, v["title"]) for k, v in data.items()][:10])
