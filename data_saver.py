from json import JSONEncoder
import json

class JsonDataEncoder(JSONEncoder):
    def default(self, o):
        return o.__dict__


def save_data(data, name):
    data = json.dumps(data, cls=JsonDataEncoder, indent=2)

    with open(f"{name}.json", "w") as f:
        f.write(data)
