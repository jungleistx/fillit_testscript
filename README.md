# fillit_testscript

Made by rvuorenl to test fillit


Usage:

(1) add path to eval_folder

    variable BASE in line 5 of 'fillit.sh'
    
    path to eval folder without trailing '/'
    
example:

    "/Users/rvuorenl/evals"
    

(2) run fillit.sh

    ./fillit <repository_name>
    
    (gives this output when ./fillit)
    
example:

    ./fillit rvuorenl_fillit
    

(3) check results (norm in terminal)

    because of time command used, tested filename is under the time + fillit output
    
    "/results" contains all individual tests
    
    "/results/fillit_<repo_name>" contains all combined (including pdf time-tests)
    
    "/results/fillit_<repo_name>_comparison" is compared with my fillit
    

(4) can be rerun with different folder, auto cleans results folder

    ./fillit atenhune_fillit
    


Error_cases

(1) issue with libft make

    uncomment lines 107 & 112 of "fillit.sh"
    
