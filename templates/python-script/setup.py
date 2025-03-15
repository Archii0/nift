from setuptools import setup

setup(
    name="PROJECTNAME",
    version="0.1",  # Initial version
    scripts=['PROJECTNAME.py'],  # List your script(s) here
    install_requires=[
        "click",        # List your dependencies here
    ],
    python_requires='>=3.6',  # Specify the minimum Python version required
)
