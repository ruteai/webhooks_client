#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys, json
from datetime import datetime, date


class DateTimeEncoder(json.JSONEncoder):
    def default(self, o):
        if isinstance(o, (datetime, date)):
            return o.isoformat()

        return json.JSONEncoder.default(self, o)


#payload = sys.stdin.read()
payload = sys.argv[1]
data = json.loads(payload)

result_data = {
    'status': 'OK',
    'dados_recebidos_pelo_webhook': data
}
print(json.dumps(result_data))