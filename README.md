# HWRF_LPI_TM
The code is available at https://dtcenter.org/HurrWRF/users/downloads/index.php HWRF System components - V3.7a 2015
After dowloding the files in this repository and dowloading the code:

Rename: 
module_mp_thompson_lpi.F module_mp_thompson.F
module_PHYSICS_CALLS_LPI.F module_PHYSICS_CALLS.F
solve_nmm_LPI.F solve_nmm.F

Replace: 
"nameofyourdirecotry"/WRFV3/phys/module_mp_thompson.F
"nameofyourdirecotory"/WRFV3/dyn_nmm/module_PHYSICS_CALLS.F
"nameofyourdirecotory"/WRFV3/dyn_nmm/solve_nmm.F

To configure and compile the code please follow the user guide: 
https://dtcenter.org/HurrWRF/users/docs/users_guide/noaa_11345_DS1.pdf