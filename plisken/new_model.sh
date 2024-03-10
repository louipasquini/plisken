echo "class "$2"(SQLModel, table=True):
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

isort --profile=black -m 3 tests/