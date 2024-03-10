echo "class "$2":
  def __init__(self,argument):
    argument: str = argument" >> src/models.py

echo "class "$2"Out:
  def __init__(self,argument):
    argument: str = argument

class "$2"In:
  def __init__(self,argument):
    argument: str = argument" > src/serializers.py

echo "from src.models import "$2"" >> src/core.py

echo "from src.serializers import "$2"Out, "$2"In" >> src/api.py

black -l 79 src tests

isort --profile=black -m 3 src/

isodr --profile=black -m 3 tests/