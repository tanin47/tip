#!/usr/bin/env python3

# Please copy this file to the folder: ~/Library/Application\ Scripts/tanin.tip/

import json
import sys


def main(input):
    items = [
        {'type': 'text', 'value': f'Input {input}'},
        {'type': 'url',  'label': f'Google {input}', 'value': f'https://google.com/search?q={input}'}
    ]

    print(json.dumps(items))


if __name__ == "__main__":
    main(sys.argv[1])