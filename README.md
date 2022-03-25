# fillit_testscript

Made by rvuorenl to test fillit


Usage:

(1) modify fillit.sh line 5

    add path to directory containing repository tested,
    
    without trailing '/'
    
example:

    "/Users/login_name/evals"
    

(2) run fillit.sh with repository name

    ./fillit <repository_name>
    
example:

    ./fillit user1_fillit
    
    (full path to repository: "/Users/login_name/evals/user1_fillit")
    

(3) check results (norm in terminal)

    because of time command used, tested filename is under the time + fillit output
    
    "/results" contains all individual tests
    
    results 1-5 are valid, results 6-18 are errors. pdftests, usage and max.txt named separately.
    
    "/results/fillit_<repo_name>" contains all combined (including pdf time-tests)
    
    "/results/fillit_<repo_name>_comparison" is compared with my teams fillit
    

(4) rerun with different fillit, auto cleans results folder

    ./fillit user2_fillit
    


Error_cases

(1) issue with libft make

    uncomment lines 113 & 118 of "fillit.sh"
    
