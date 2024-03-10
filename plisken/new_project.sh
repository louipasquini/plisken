mkdir "$2" "$2"/src "$2"/tests

echo "Directory: OK"

touch "$2"/README.md "$2"/src/__init__.py "$2"/src/core.py "$2"/tests/__init__.py

echo 'from typing import Optional

import typer
from rich.console import Console
from rich.table import Table

main = typer.Typer(help="New Title")
console = Console()' > "$2"/src/cli.py

echo 'from sqlmodel import select

from src.database import get_session' > "$2"/src/core.py

echo 'name = "'"$2"'"

[database]
url = "sqlite:///'"$2"'.db"' > "$2"/src/settings.toml

echo 'from datetime import datetime

from fastapi import HTTPException, status
from pydantic import BaseModel, validator' > "$2"/src/serializers.py

echo 'from datetime import datetime
from typing import Optional

from pydantic import validator
from sqlmodel import Field, SQLModel' > "$2"/src/models.py

echo 'from fastapi import FastAPI

from src.database import get_session

api = FastAPI(title="New Title")' > "$2"/src/api.py

echo 'import warnings

from sqlalchemy.exc import SAWarning
from sqlmodel import Session, create_engine
from sqlmodel.sql.expression import Select, SelectOfScalar

from src import models
from src.config import settings

warnings.filterwarnings("ignore", category=SAWarning)
SelectOfScalar.inherit_cache = True
Select.inherit_cache = True

engine = create_engine(settings.database.url)

models.SQLModel.metadata.create_all(engine)

def get_session():
  return Session(engine)' > "$2"/src/database.py

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

echo 'echo "class "$2"(SQLModel, table=True):
  id: Optional[int] = FIeld(primary_key=True, default=None, index=True)
  date: datetime = Field(default_factory=datetime.now)
" >> src/models.py

echo "class "$2"Out(BaseModel):
  id: int
  date: datetime

class "$2"In(BaseModel):
  id: int
  date: datetime" >> src/serializers.py

echo "from src.models import "$2"" | cat - src/core.py > temp && mv temp src/core.py

echo "from src.serializers import "$2"Out, "$2"In" | cat - src/api.py > temp && mv temp src/api.py

black -l 79 src tests

isort --profile=black -m 3 src/

isort --profile=black -m 3 tests/' > "$2"/new_model.sh

echo 'echo "def "$2"() -> bool:
  return True" >> src/core.py

echo "from src.core import "$2"" >> src/api.py

echo "from src.core import "$2"" >> src/cli.py

echo "from src.core import "$2"

def test_"$2"():
  assert "$2"" >> tests/test_core.py

black -l 79 src tests

isort --profile=black -m 3 src/

isort --profile=black -m 3 tests/
' > "$2"/new_function.sh

touch "$2"/tests/test_core.py

echo "from typer.testing import CliRunner

from src.api import api

runner = CliRunner()" > "$2"/tests/test_functional_api.py

echo "from src.cli import main" > "$2"/tests/test_functional_cli.py

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

echo "annotated-types==0.6.0
anyio==4.3.0
click==8.1.7
exceptiongroup==1.2.0
fastapi==0.110.0
idna==3.6
markdown-it-py==3.0.0
mdurl==0.1.2
numpy==1.26.4
pydantic==2.6.3
pydantic_core==2.16.3
Pygments==2.17.2
rich==13.7.1
sniffio==1.3.1
starlette==0.36.3
typer==0.9.0
typing_extensions==4.10.0
" > "$2"/requirements.txt

echo "Requirements: OK"

clear

echo 'Project '"$2"' created.

On console:
cd '"$2"'
source env/bin/activate
plisken install'