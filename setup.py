
import setuptools

__version__ = '1.0'

setuptools.setup(
    name="msfbe",
    version=__version__,
    url="https://github-fn.jpl.nasa.gov/methanesourcefinder/msf-be.git",

    author="Caltech/Jet Propulsion Laboratory",

    description="MSF-BE API.",
    long_description=open('README.md').read(),
    package_dir={'':'src'},
    packages=['msfbe', 'msfbe.handlers'],
    package_data={'msfbe': ['config.ini']},
    data_files=[

    ],
    platforms='any',

    install_requires=[
        'tornado',
        'numpy',
        'singledispatch',
        'pytz',
        'requests',
        'utm',
        'shapely',
        'mock',
        'backports.functools-lru-cache==1.3',
        'boto3',
        'pillow==5.0.0',
        'psycopg2',
        'six',
        'psutil'
    ],

    classifiers=[
        'Development Status :: 1 - Pre-Alpha',
        'Intended Audience :: Developers',
        'Operating System :: OS Independent',
        'Programming Language :: Python :: 2.7',
    ]
)
