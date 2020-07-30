rm -rf venv
python3 -m venv venv
venv/bin/pip install --upgrade pip setuptools wheel
venv/bin/pip install .

venv/bin/coverage erase
rm -rf htmlcov
venv/bin/coverage run --rcfile .coveragerc -m covtest
venv/bin/coverage html
echo ------- root
venv/bin/coverage report
grep -r missing htmlcov/*__main__*

echo
echo

rm -rf empty
mkdir empty
cd empty
../venv/bin/coverage erase
rm -rf htmlcov
../venv/bin/coverage run --rcfile ../.coveragerc -m covtest
../venv/bin/coverage html
echo ------- empty/
../venv/bin/coverage report
grep -r missing htmlcov/*__main__*
cd -
