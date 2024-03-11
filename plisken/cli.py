import typer
import os
import subprocess
from rich.console import Console

main = typer.Typer(help="Plisken Project")

console = Console()

@main.command("project")
def create_project(project_name: str):
  """Create a new project"""
  this_path = os.path.dirname(os.path.abspath(__file__))
  path = os.getcwd()
  subprocess.run(["bash",this_path+"/new_project.sh",path,project_name])

@main.command("model")
def create_model(model_name: str):
  """Create a new model"""
  this_path = os.path.dirname(os.path.abspath(__file__))
  path = os.getcwd()
  subprocess.run(["bash",path+"/.plisken/new_model.sh",path,model_name])

@main.command("function")
def create_function(function_name: str):
  """Create a new function"""
  this_path = os.path.dirname(os.path.abspath(__file__))
  path = os.getcwd()
  subprocess.run(["bash",path+"/.plisken/new_function.sh",path,function_name])

@main.command("install")
def install_dependencies():
  """Install dependencies"""
  os.system("pip install -r requirements.txt")

@main.command("add")
def add_dependency(dependency_name: str):
  """Add dependencies"""
  os.system(f"pip install {dependency_name} && pip freeze > requirements.txt")