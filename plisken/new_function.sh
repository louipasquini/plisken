echo "def "$2"():
  pass" >> src/core.py

echo "from src.core import "$2"" >> src/api.py

echo "from src.core import "$2"" >> src/cli.py

echo "from src.core import "$2"

def test_"$2"():
  assert "$2"" >> tests/test_core.py

black -l 79 src tests

isort --profile=black -m 3 src/

isodr --profile=black -m 3 tests/
