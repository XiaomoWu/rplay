########################################################################
#
#     This is an example call of MIDACO 6.0
#     -------------------------------------
#
#     MIDACO solves Multi-Objective Mixed-Integer Non-Linear Problems:
#
#
#      Minimize     F_1(X),... F_O(X)  where X(1,...N-NI)   is CONTINUOUS
#                                      and   X(N-NI+1,...N) is DISCRETE
#
#      subject to   G_j(X)  =  0   (j=1,...ME)      equality constraints
#                   G_j(X) >=  0   (j=ME+1,...M)  inequality constraints
#
#      and bounds   XL <= X <= XU
#
#
#     The problem statement of this example is given below. You can use 
#     this example as template to run your own problem. To do so: Replace 
#     the objective functions 'F' (and in case the constraints 'G') given 
#     here with your own problem and follow the below instruction steps.
#
########################################################################
######################   OPTIMIZATION PROBLEM   ########################
########################################################################
problem_function <- function(f,g,x) 
{
      # Objective functions F(X)
      f[1] = (x[1]-1)^2 + 
             (x[2]-2)^2 + 
             (x[3]-3)^2 + 
             (x[4]-4)^2 + 1.23456789

      # Equality constraints G(X) = 0 MUST COME FIRST in g[1:me]
      g[1] = x[1] - 1
      # Inequality constraints G(X) >= 0 MUST COME SECOND in g[me+1:m] 
      g[2] = x[2] - 1.333333333
      g[3] = x[3] - 2.666666666

      output <- list(f,g)
      return(output)
}
########################################################################
#########################   MAIN PROGRAM   #############################
########################################################################

key='MIDACO_LIMITED_VERSION___[CREATIVE_COMMONS_BY-NC-ND_LICENSE]'      

########################################################################
### Step 1: Problem definition     #####################################
########################################################################

# STEP 1.A: Problem dimensions
##############################
problem.o  = 1  # Number of objectives 
problem.n  = 4  # Number of variables (in total) 
problem.ni = 2  # Number of integer variables (0 <= ni <= n) 
problem.m  = 3  # Number of constraints (in total) 
problem.me = 1  # Number of equality constraints (0 <= me <= m) 

# STEP 1.B: Lower and upper bounds 'xl' & 'xu'  
##############################################  
problem.xl = c( 1, 1, 1, 1 )
problem.xu = c( 4, 4, 4, 4 )

# STEP 1.C: Starting point 'x'  
##############################   
problem.x = problem.xl # Here for example: starting point = lower bounds

########################################################################
### Step 2: Choose stopping criteria and printing options    ###########
########################################################################
   
# STEP 2.A: Stopping criteria 
############################# 
option.maxeval = 10000     # Maximum evaluation budget (e.g. 1000000)
option.maxtime = 60*60*24  # Maximum time limit in Seconds (e.g. 1 Day = 60*60*24) 

# STEP 2.B: Printing options  
############################  
option.printeval = 1000 # Print-Frequency for current best solution (e.g. 1000)
option.save2file = 1    # Save SCREEN and SOLUTION to TXT-files [0=NO/1=YES]

########################################################################
### Step 3: Choose MIDACO parameters (FOR ADVANCED USERS)    ###########
########################################################################

option.param1  =  0.0  # ACCURACY   
option.param2  =  0.0  # SEED  
option.param3  =  0.0  # FSTOP  
option.param4  =  0.0  # ALGOSTOP  
option.param5  =  0.0  # EVALSTOP  
option.param6  =  0.0  # FOCUS  
option.param7  =  0.0  # ANTS  
option.param8  =  0.0  # KERNEL  
option.param9  =  0.0  # ORACLE  
option.param10 =  0.0  # PARETOMAX
option.param11 =  0.0  # EPSILON  
option.param12 =  0.0  # BALANCE
option.param13 =  0.0  # CHARACTER         

########################################################################
### Step 4: Choose Parallelization Factor   ############################
########################################################################

option.parallel = 0 # Serial: 0 or 1, Parallel: 2,3,4,5,6,7,8...

########################################################################
############################ Run MIDACO ################################
########################################################################

source('midaco.r')

solution = midaco_run( problem, option, key )

# f     = solution[[1]];  cat('solution f     ', f     ,'\n')
# g     = solution[[2]];  cat('solution g     ', g     ,'\n')
# x     = solution[[3]];  cat('solution x     ', x     ,'\n')

########################################################################
############################ END OF FILE ###############################
########################################################################


