function test_suite = test_local_minimum
    initTestSuite;
    
function test_simple_case_min
	in = [0  0  0  0  0  0  0
          0  0  0  0  0  0  0
          0  0  0  0  0  0  0
          0  0  0 -1  0  0  0
          0  0  0  0  0  0  0
          0  0  0  0  0  0  0
          0  0  0  0  0  0  0];
    expected = true;
    actual = is_local_minimum(in, [4, 4]);
    assertEqual(actual, expected);
    
function test_simple_case_not_min
	in = [0  0  0  0  0  0  0
          0  0  0  0  0  0  0
          0  0  0  0  0  0  0
          0  0  0  1  0  0  0
          0  0  0  0  0  0  0
          0  0  0  0  0  0  0
          0  0  0  0  0  0  0];
    expected = false;
    actual = is_local_minimum(in, [4, 4]);
    assertEqual(actual, expected);
    
function test_strict_inequality
	in = [10  9  8  7  8  9 10
           9  8  7  6  7  8  9
           8  7  6  5  6  7  8
           7  6  5  5  5  6  7
           8  7  6  5  6  7  8
           9  8  7  6  7  8  9
          10  9  8  7  8  9 10];
    expected = false;
    actual = is_local_minimum(in, [4, 4]);
    assertEqual(actual, expected);
    
function test_radius
	in = [-1  0  0  0  0  0  0
           0  0  0  0  0  0  0
           0  0  0  0  0  0  0
           0  0  0 -1  0  0  0
           0  0  0  0  0  0  0
           0  0  0  0  0  0  0
           0  0  0  0  0  0  0];
    expected = false;
    actual = is_local_minimum(in, [4, 4]);
    assertEqual(actual, expected);
    
function test_simple_pass
	in = [-0.9  0  0  0  0  0  0
             0  0  0  0  0  0  0
             0  0  0  0  0  0  0
             0  0  0 -1  0  0  0
             0  0  0  0  0  0  0
             0  0  0  0  0  0  0
             0  0  0  0  0  0  0];
    expected = true;
    actual = is_local_minimum(in, [4, 4]);
    assertEqual(actual, expected);