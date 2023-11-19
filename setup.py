import os

from air_hockey_challenge import __version__
from setuptools import find_packages, setup

with open(
    os.path.join(os.path.dirname(__file__), "requirements.txt")
) as requirements_file:
    requirements = requirements_file.read().splitlines()
    requirements = [
        line.strip() for line in requirements if line and not line.startswith("#")
    ]
    dependency_links = [
        line.strip().split(" ")[-1]
        for line in requirements
        if line.strip().startswith("--extra-index-url")
    ]
    install_requires = [
        line
        for line in requirements
        if not line.startswith("--extra-index-url") and not line.startswith("git+")
    ]
    install_requires_from_git = [
        line.split("#egg=")[-1].split("&")[0].split("#")[0].split(",")[0] + " @ " + line
        for line in requirements
        if not line.startswith("--extra-index-url") and line.startswith("git+")
    ]

setup(
    name="AirHockeyChallenge",
    version=__version__,
    url="https://github.com/AirHockeyChallenge/air_hockey_challenge",
    author="Jonas Guenster",
    author_email="air-hockey-challenge@robot-learning.net",
    description="Package that provides the environments and frameworks for the 2023 Air Hockey Challenge.",
    packages=find_packages(),
    dependency_links=dependency_links,
    install_requires=install_requires + install_requires_from_git,
)
