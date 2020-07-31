set -evx

rm -rf venv
python3 -m venv venv
venv/bin/pip install --upgrade pip setuptools wheel
venv/bin/pip install .

echo

venv/bin/python --version --version
git show --no-patch HEAD
venv/bin/pip freeze --all
venv/bin/coverage debug sys

venv/bin/coverage erase
rm -rf htmlcov
venv/bin/coverage run --rcfile .coveragerc -m covtest
venv/bin/coverage html
echo ------- root
venv/bin/coverage report
echo
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
echo
grep -r missing htmlcov/*__main__*
cd -
