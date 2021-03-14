"""
Added by CARB 3/14/2021
"""

import json
from msfbe.webmodel import BaseHandler, service_handler


@service_handler
class HandlerImpl(BaseHandler):
    name = "Landing Page"
    path = "/"
    description = "Provides a valid return at / in order to pass Fargate health checks"
    params = {}
    singleton = True

    def __init__(self):
        BaseHandler.__init__(self)

    def handle(self, computeOptions, **args):
        class SimpleResult(object):
            def __init__(self, result):
                self.result = result

            def toJson(self):
                return json.dumps(self.result)

        return SimpleResult({"API Status":"UP"})