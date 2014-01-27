function RunUnitTests
    addpath(genpath(fullfile(pwd,'../xunit_3_1_1/')));
    suite = TestSuite.fromName('unit_tests/');
    suite.run;
end