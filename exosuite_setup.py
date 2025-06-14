import os
import subprocess
import sys

def create_structure():
    dirs = [
        'src/exosuite',
        'tests',
        'docs',
        'scripts',
        'config'
    ]
    files = {
        'README.md': '# ExoSuite\n\nProject description.',
        'setup.py': 'from setuptools import setup, find_packages\n\nsetup(name="exosuite", version="0.1", packages=find_packages(where="src"), package_dir={"": "src"})',
        'requirements.txt': '',
        'pyproject.toml': '[tool.black]\nline-length = 88\n\n[tool.isort]\nprofile = "black"\n\n[tool.pytest.ini_options]\ntestpaths = ["tests"]',
        'src/exosuite/__init__.py': '',
        'tests/__init__.py': '',
        'tests/test_sample.py': 'def test_example():\n    assert True',
        'scripts/__init__.py': '',
        'config/__init__.py': ''
    }

    for dir in dirs:
        os.makedirs(dir, exist_ok=True)

    for file, content in files.items():
        with open(file, 'w') as f:
            f.write(content)

def install_dependencies():
    subprocess.check_call([sys.executable, '-m', 'pip', 'install', '--upgrade', 'pip'])
    subprocess.check_call([sys.executable, '-m', 'pip', 'install', 'pytest', 'black', 'isort'])

def main():
    create_structure()
    install_dependencies()
    print("ExoSuite structure created and dependencies installed.")

if __name__ == '__main__':
    main()
