from setuptools import setup

setup(name='YourAppName',
      version='1.0',
      description='OpenShift App',
      author='Your Name',
      author_email='example@example.com',
      url='https://www.python.org/community/sigs/current/distutils-sig',
      install_requires=['nltk','feedparser','sqlalchemy','dateparser','bs4','urllib3','Flask>=0.7.2','flask-restful','Flask-JSON','flask-cors', 'MarkupSafe','cryptography'],
      )
#  'dateparser','bs4','urllib3', install_requires=['Flask>=0.7.2','flask-restful','Flask-JSON','flask-cors','mysql-connector-python>=1.0.12', 'MarkupSafe','cryptography'],