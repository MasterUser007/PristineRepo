
import pytest

def test_addition():
    assert 2 + 2 == 4

def test_multiplication():
    assert 3 * 3 == 9

def test_division_by_zero():
    with pytest.raises(ZeroDivisionError):
        result = 1 / 0

