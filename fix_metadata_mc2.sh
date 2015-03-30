#!/bin/sh

#updates metadata in netcdfs according to suggestions at
#http://www.unidata.ucar.edu/software/thredds/current/netcdf-java/formats/DataDiscoveryAttConvention.html
#and consistent with other projects in Integrate Scenarios of Pacific Northwest

#========================================================
#    REPLACEMENTS
#========================================================
TITLE='MC2 (landcarbon branch) vegetation simulations using MACAv1-METDATA CMIP5 forcings over the western USA.'
SUMMARY='This archive contains vegetation variables at an annual timestep and 1/24-degree horizontal resolution for the western conterminous United states produced by the MC2 Dynamic Global Vegetation Model. The MC2 model is composed of three modules that simulate biogeography, biogeochemistry, and wildfire interactions. MC2 simulates shifts in potential vegetation types (individual species are not simulated), C fluxes and dynamic wildfires. The simulations were forced with statistically downscaled global climate model (GCM) for the future period (2005-2100) using the method of Multivariate Adaptive Constructed Analogs (MACAv1-METDATA; Abatzoglou and Brown 2012) and trained to METDATA (Abatzoglou 2012) gridded surface observations and for the historical period (1915-2010) using PRISM (Daly et al, 2008). Four downscaled meteorological variables were used at a monthly timestep: (1) average of daily minimum temperature and (2) daily maximum temperature, (3) precipitation, and (4) specific humidity. The downscaled forcings were constructed using 365-day global climate model (GCM) outputs from the Coupled Model Inter-comparison Project Phase (CMIP5). The model is run at a monthly time step on a spatially explicit grid. Each grid cell is simulated independently, with no cell-to-cell communication. For this project, the potential vegetation is that which would occur without direct human influence. Indirect impacts such as increasing atmospheric CO2 concentrations and fire suppression were included.'

KEYWORDS='Vegetation, MC2, biogeography, biogeochemistry, fire, carbon, water, vegetation cover, MACA statistical downscaling, CMIP5, actual evapotranspiration, maximum value of the build-up index (numerical rating of the total amount of fuel available for combustion), biomass consumed by wildfires, aboveground dead plant organic matter (in carbon units) (i.e. standing dead grasses, litter and coarse woody debris), belowground dead organic matter (in carbon units) (i.e. dead roots, soil organic matter), total ecosystem organic matter (in carbon units) (live and dead plant parts including roots and soil organic matter), forest biomass (in carbon units) (above and belowground live plant parts), carbon leached from roots into the soil, litter, live aboveground plant biomass (in carbon units) (i.e. leaves, stems, branches and boles), live belowground plant biomass (in carbon units) (i.e. roots), maximum forest leaf biomass (in carbon units), maximum aboveground grass biomass (in carbon units), maximum grass root biomass (in carbon units), maximum grasss standing dead organic matter (in carbon units), soil and dead plant organic matter (in carbon units) (including coarse woody debris), soil organic matter and belowground litter (in carbon units), soil organic matter (3 pools) (in carbon units), live vegetation biomass (in carbon units) (grasses and trees), maximum fine fuel moisture content, streamflow, maximum grass leaf area index, maximum surface runoff, maximum tree leaf area index, net biological production, net ecosystem production, net primary production, nitrogen fixation, nitrogen volatilization, fraction of the area burned, potential evapotranspiration, soil respiration (heterotrophic), potential vegetation type, AET, BUI_ANN_MAX, CONSUMED, C_DEAD_ABOVEGR, C_DEAD_BELOWGR, C_DEAD_WOOD, C_ECOSYS, C_FOREST, C_LEACHED, C_LITTER, C_LIVE_ABOVEGR, C_LIVE_BELOWGR, C_MAX_FOREST_LEAF, C_MAX_LIVE_GRASS_ABOVEGR, C_MAX_LIVE_GRASS_BELOWGR, C_MAX_STANDING_DEAD, C_SOIL_AND_LITTER, C_SOM, C_SOM_X_STRUC_METAB, C_VEG, FFMC_ANN_MAX, H2O_STREAM_FLOW, MAX_GRASS_LAI, MAX_SFC_RUNOFF, MAX_TREE_LAI, NBP, NEP, NPP, N_FIX, N_VOLATIL, PART_BURN, PET, RSP, VTYPE'


#=============
#  RECOMMENDED 
#=============
ID='';  #leave blank, NKN will have to fix later
NAMINGAUTHORITY="edu.uidaho.nkn"
#KEYWORDS_VOCABULARY="None"
CDM_DATA_TYPE='GRID';
HISTORY= 'Created by Tim Sheehan, Conservation Biology Institute'; 
#DATE_CREATED=''; # See netcdf file
#CREATOR_NAME=''; # See netcdf file
#CREATOR_URL=''; # See netcdf file
CREATOR_ROLE='Ecological Modeler';
#CREATOR_EMAIL=''; # See netcdf file
#INSTITUTION=''; # See netcdf file
#PROJECT="Integrated Scenarios Project of the Northwest Climate Sciences Center"
PROCESSING_LEVEL='Gridded Vegetation Projections';

#Needed
ACKNOWLEDGMENT="Please reference the Northwest Climate Science Center (NW CSC) US Geological Survey Grant Number G12AC20495 and the references included herein. We acknowledge the World Climate Research Programme's Working Group on Coupled Modelling, which is responsible for CMIP, and we thank the climate modeling groups for producing and making available their model output. For CMIP the U.S. Department of Energy's Program for Climate Model Diagnosis and Intercomparison provides coordinating support and led development of software infrastructure in partnership with the Global Organization for Earth System Science Portals.";

GEOSPATIAL_LAT_MIN=31.04167;
GEOSPATIAL_LAT_MAX=49;
#GEOSPATIAL_LON_MIN= ; # See netcdf file
#GEOSPATIAL_LON_MAX= ; # See netcdf file
GEOSPATIAL_VERTICAL_MIN=0;
GEOSPATIAL_VERTICAL_MAX=0;

TIME_COVERAGE_START='' # see year_min in netcdf file
TIME_COVERAGE_END='' # see year_max in netcdf file
TIME_COVERAGE_DURATION='' # calculate from year_min and year_max
TIME_COVERAGE_RESOLUTION='P1Y';

#STANDARD_NAME_VOCABULARY=''; # I think CF-1.5
LICENSE='No restrictions';

#=============
#  SUGGESTED 
#=============
CONTRIBUTOR_NAME=''; # see netcdf file
CONTRIBUTOR_ROLE='Ken Ferschweiler - Senior Software Developer; Dominique Bachelet - PI';
CONTRIBUTOR_ROLE='Ken Ferschweiler - ken@consbio.org; Dominique Bachelet - dominique@consbio.org';
PUBLISHERNAME="Northwest Knowledge Network"
PUBLISHEREMAIL="info@northwestknowledge.net"
PUBLISHERURL="http://www.northwestknowledge.net"

#DATE_MODIFIED ='' # see date_created in netcdf file
#DATE_ISSUED =''# see date_created in netcdf file

GEOSPATIAL_LAT_UNITS='decimal degrees north' # currently listed as degrees_north
GEOSPATIAL_LON_UNITS='decimal degrees east' # currently listed as degrees_north
#GEOSPATIAL_LAT_RESOLUTION='Only applicable in rotated coordinates. See "geospatial comment".' #??????
#GEOSPATIAL_LON_RESOLUTION='Only applicable in rotated coordinates. See "geospatial comment".' #??????
GEOSPATIAL_VERTICAL_UNITS='None'
GEOSPATIAL_VERTICAL_RESOLUTION='0'
GEOSPATIAL_VERTICAL_POSITIVE='Up'

#========================================================
#    PERFORM REPLACEMENTS USING NCL
#========================================================
MODELS=("bcc-csm1-1" "bcc-csm1-1-m" "BNU-ESM" "CanESM2" "CCSM4" "CNRM-CM5" "CSIRO-Mk3-6-0" "inmcm4" "MIROC5" "GFDL-ESM2G" "GFDL-ESM2M" "HadGEM2-ES365" "HadGEM2-CC365" "IPSL-CM5B-LR" "IPSL-CM5A-MR" "IPSL-CM5A-LR" "MRI-CGCM3" "MIROC-ESM" "MIROC-ESM-CHEM" "NorESM1-M")

#GCMSOURCE="CMIP5: CCSM4 (University of Miami -RSMAS) global climate model, historical scenario, r6i1p1 ensemble run"
MODELNAME=(
"Beijing Climate Center, China Meteorological Administration"
"Beijing Climate Center, China Meteorological Administration"
"Canadian Centre for Climate Modelling and Analysis"
"College of Global Change and Earth System Science, Beijing Normal University"
"University of Miami - RSMAS"
"Centre National de Recherches Meteorologiques /Centre Europeen de Recherche et Formation Avancees en Calcul Scientifique"
"Commonwealth Scientific and Industrial Research Organization in collaboration with Queensland Climate Change Centre of Excellence"
"Institute for Numerical Mathematics"
"Atmosphere and Ocean Research Institute (The University of Tokyo), National Institude for Environmental Studies, and Japan Agency for Marine-Earth Science and Technology"
"NOAA Geophysical Fluid Dynamics Laboratory"
"NOAA Geophysical Fluid Dynamics Laboratory"
"Met Office Hadley Centre"
"Met Office Hadley Centre"
"Institute Pierre-Simon Laplace"
"Institute Pierre-Simon Laplace"
"Institute Pierre-Simon Laplace"
"Meteorological Research Institute"
"Japan Agency for Marine-Earth Science and Technology, Atmosphere and Ocean Research Institute (The University of Tokyo), and National Institute for Environmental Studies"
"Norwegian Climate Centre"
)

$modelnum=0
for model in "${MODELS[@]}"
do
        cd "$model" 
	$modelnum=$modelnum+1;
	$modelname=MODELNAME($modelnum)
    	$runnum="1"
        if["$model" -eq "CCSM4"]
        then
                $runnum="6"
        fi

	  for i in *historical*.nc;do
                $scenname="historical"
                GCMSOURCE="CMIP5:{$model} ({$modelname}) global climate model, {$scenname} scenario, r{$runnum}i1p1 ensemble run"
                ncatted -O -h -a gcmsource,global,c,c,"$GCMSOURCE" $i
        done
        for i in *rcp45*.nc;do
                $scenname="RCP 4.5"
                GCMSOURCE="CMIP5:{$model} ({$modelname}) global climate model, {$scenname} scenario, r{$runnum}i1p1 ensemble run"
                ncatted -O -h -a gcmsource,global,c,c,"$GCMSOURCE" $i
        done

        for i in *rcp85*.nc;do
                $scenname="RCP 8.5"
                GCMSOURCE="CMIP5:{$model} ({$modelname}) global climate model, {$scenname} scenario, r{$runnum}i1p1 ensemble run"
                ncatted -O -h -a gcmsource,global,c,c,"$GCMSOURCE" $i
        done

        for i in *.nc;do
                echo $i
		#=============
		#  HIGHLY RECOMMENDED 
		#=============
                ncatted -O -h -a title,global,m,c,"$TITLE" $i
                ncatted -O -h -a summary,global,m,c,"$SUMMARY" $i
                #ncatted -O -h -a keywords,global,m,c,"$KEYWORDS" $i

		#=============
		#  RECOMMENDED 
		#=============
                ncatted -O -h -a id,global,m,c,"$ID" $i
                ncatted -O -h -a naming_authority,global,m,c,"$NAMINGAUTHORITY" $i
                #ncatted -O -h -a keywords_vocabulary,global,m,c,"$KEYWORDS_VOCABULARY" $i
                ncatted -O -h -a cdm_data_type,global,m,c,"$CDM_DATA_TYPE" $i
                ncatted -O -h -a history,global,m,c,"$HISTORY" $i
                #ncatted -O -h -a comment,global,m,c,"$COMMENT" $i

                ncatted -O -h -a date_created,global,m,c,"$DATE_CREATED" $i
                ncatted -O -h -a creator_name,global,m,c,"$CREATOR_NAME" $i
                ncatted -O -h -a creator_url,global,m,c,"$CREATOR_URL" $i
                ncatted -O -h -a creator_role,global,m,c,"$CREATOR_ROLE" $i
                ncatted -O -h -a creator_email,global,m,c,"$CREATOR_EMAIL" $i
                #ncatted -O -h -a institution,global,m,c,"$INSTITUTION" $i
            
		#ncatted -O -h -a project,global,m,c,"$PROJECT" $i
                ncatted -O -h -a processing_level,global,m,c,"$PROCESSING_LEVEL" $i
                ncatted -O -h -a acknowledgment,global,m,c,"$ACKNOWLEDGMENT" $i

		#might need to hard code these values directly here
 		ncatted -O -h -a geospatial_lat_min,global,m,f,GEOSPATIAL_LAT_MIN $i
                ncatted -O -h -a geospatial_lat_max,global,m,f,GEOSPATIAL_LAT_MAX $i
                ncatted -O -h -a geospatial_lon_min,global,m,f,GEOSPATIAL_LON_MIN $i
                ncatted -O -h -a geospatial_lon_max,global,m,f,GEOSPATIAL_LON_MAX $i
                ncatted -O -h -a geospatial_vertical_min,global,m,f,GEOSPATIAL_VERTICAL_MIN $i
                ncatted -O -h -a geospatial_vertical_max,global,m,f,GEOSPATIAL_VERTICAL_MAX $i

  		ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
  		ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
                ncatted -O -h -a time_coverage_resolution,global,m,c,"$TIME_COVERAGE_RESOLUTION" $i


                ncatted -O -h -a standard_name_vocabulary,global,m,c,"$STANDARD_NAME_VOCABULARY" $i
                ncatted -O -h -a license,global,m,c,"$LICENSE" $i

		#=============
		#   SUGGESTED
		#=============
                ncatted -O -h -a contributor_name,global,m,c,"$CONTRIBUTOR_NAME" $i
                ncatted -O -h -a contributor_role,global,m,c,"$CONTRIBUTOR_ROLE" $i
                ncatted -O -h -a contributor_email,global,m,c,"$CONTRIBUTOR_EMAIL" $i

		ncatted -O -h -a publisher_name,global,m,c,"$PUBLISHERNAME" $i
                ncatted -O -h -a publisher_url,global,m,c,"$PUBLISHERURL" $i
                ncatted -O -h -a publisher_email,global,m,c,"$PUBLISHEREMAIL" $i

                ncatted -O -h -a date_modified,global,m,c,"$DATE_MODIFIED" $i
                ncatted -O -h -a date_issued,global,m,c,"$DATE_ISSUED" $i

                ncatted -O -h -a geospatial_lat_units,global,m,f,GEOSPATIAL_LAT_UNITS $i
                ncatted -O -h -a geospatial_lat_resolution,global,m,f,GEOSPATIAL_LAT_RESOLUTION $i
                ncatted -O -h -a geospatial_lon_units,global,m,f,GEOSPATIAL_LON_UNITS $i
                ncatted -O -h -a geospatial_lon_resolution,global,m,f,GEOSPATIAL_LON_RESOLUTION $i
                ncatted -O -h -a geospatial_vertical_units,global,m,c,"$GEOSPATIAL_VERTICAL_UNITS" $i
                ncatted -O -h -a geospatial_vertical_resolution,global,m,c,"$GEOSPATIAL_VERTICAL_RESOLUTION" $i
                ncatted -O -h -a geospatial_vertical_positive,global,m,c,"$GEOSPATIAL_VERTICAL_POSITIVE" $i
        done
        cd ../
done

