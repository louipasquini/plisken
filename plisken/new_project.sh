mkdir "$2" "$2"/src "$2"/tests

echo "Directory: OK"

touch "$2"/README.md "$2"/src/__init__.py "$2"/src/cli.py "$2"/src/api.py "$2"/src/core.py "$2"/src/models.py "$2"/src/database.py "$2"/src/serializers.py "$2"/src/settings.toml "$2"/tests/__init__.py

echo "Archives: OK"

echo 'from .cli import main

if __name__ == "__main__":
  main()' > "$2"/src/__main__.py

echo "__main__.py: OK"

echo 'import os

from dynaconf import dynaconf

settings = Dynaconf(
  envvar_prefix='"$2"',
  root_path=os.path.dirname(__file__),
  settings_files=["settings.toml"]
)' > "$2"/src/config.py

echo "Config.py: OK"

echo 'echo "class "$2":
  def __init__(self,argument):
    argument: str = argument" >> src/models.py

echo "class "$2"Out:
  def __init__(self,argument):
    argument: str = argument

class "$2"In:
  def __init__(self,argument):
    argument: str = argument" >> src/serializers.py

echo "from src.models import "$2"" | cat - src/core.py > temp && mv temp src/core.py

echo "from src.serializers import "$2"Out, "$2"In" | cat - src/api.py > temp && mv temp src/api.py

black -l 79 src tests

isort --profile=black -m 3 src/

isort --profile=black -m 3 tests/' > "$2"/new_model.sh

echo 'echo "def "$2"():
  pass" >> src/core.py

echo "from src.core import "$2"" >> src/api.py

echo "from src.core import "$2"" >> src/cli.py

echo "from src.core import "$2"

def test_"$2"():
  assert "$2"" >> tests/test_core.py

black -l 79 src tests

isort --profile=black -m 3 src/

isort --profile=black -m 3 tests/' > "$2"/new_function.sh

touch "$2"/test_functional_api.py "$2"/test_functional_cli.py "$2"/test_core.py

cd "$2"

pip install --upgrade pip

echo "Upgrade pip: OK"

python3 -m venv env

echo "Create env: OK"

source env/bin/activate

echo "Activate env: OK"

pip install dynaconf

pip install pytest

echo "Install dynaconf: OK"

pip freeze > requirements.txt

echo "Requirements: OK"

clear

echo 'Project '"$2"' created.

On console:
cd '"$2"'
source env/bin/activate
plisken install'