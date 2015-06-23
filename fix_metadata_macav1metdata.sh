#!/bin/sh

#updates metadata in netcdfs according to suggestions at
#http://www.unidata.ucar.edu/software/thredds/current/netcdf-java/formats/DataDiscoveryAttConvention.html
#and consistent with other projects in Integrate Scenarios of Pacific Northwest

#notes: if the attribute is not currently in the file, we have to create the attribute with mode c like:
#ncatted -O -h -a publisher_email,global,c,c,"$PUBLISHEREMAIL" $i
#whereas if it already exists, we just have to modify it with mode m like:
#ncatted -O -h -a publisher_email,global,m,c,"$PUBLISHEREMAIL" $i
#however.. we can just use create c on everything and it will all work just fine
#but if we know that the files already have a field, using mode m might increase the speed

#========================================================
#    REPLACEMENTS
#========================================================
TITLE="MACAv1-METDATA statistically downscaled climate simulations using CMIP5 forcings over the contiguous USA"
DAILYSUMMARY="This archive contains meteorological variables at the daily timestep and 1/24-deg horizontal resolution for the western United States produced by the MACAv1-METDATA (Multivariate Adaptive Constructed Analogs) statistical downscaling method (by Abatzoglou and Brown, 2012) performed on daily outputs from global climate model simulations of the historical (1950-2005) and future RCP4.5/8.5 (2006-2099) scenarios of the Coupled Model Intercomparison Project Phase 5 (CMIP5) utilizing the METDATA (Abatzoglou, 2012) training dataset. The MACA method removes biases in the global model variables and spatial downscales them using a variation of the constructed analogs method."
MONTHLYSUMMARY="This archive contains meteorological variables at the monthly timestep and 1/24-deg horizontal resolution for the western United States produced by the MACAv1-METDATA (Multivariate Adaptive Constructed Analogs) statistical downscaling method (by Abatzoglou and Brown, 2012) performed on daily outputs from global climate model simulations of the historical (1950-2005) and future RCP4.5/8.5 (2006-2099) scenarios of the Coupled Model Intercomparison Project Phase 5 (CMIP5) utilizing the METDATA (Abatzoglou, 2012) training dataset. The MACA method removes biases in the global model variables and spatial downscales them using a variation of the constructed analogs method."
KEYWORDS="MACA,CMIP5,METDATA,maximum temperature,minimum temperature, precipitation amount, downward shortwave solar radiation, wind components, specific humidity, relative humidity"
CONVENTIONS="CF-1.0, Unidata Data Discovery 1.1"

#=============
#  RECOMMENDED 
#=============
ID=" ";  #leave blank, NKN will have to fix later
NAMINGAUTHORITY="edu.uidaho.nkn"
KEYWORDS_VOCABULARY="None"
CDM_DATA_TYPE="GRID";
DAILYHISTORY="Created by Katherine Hegewisch,University of Idaho, Department of Geography, Applied Climate Science Lab";
MONTHLYHISTORY="Created by Katherine Hegewisch,University of Idaho, Department of Geography, Applied Climate Science Lab";
#would need to run over the models and enter the right info here
#COMMENT="Monthly outputs have been aggregated from daily outputs of the MACA downscaling of daily outputs from r1i1p1 ensemble, CCSM4 GCM (from University of Miami - RSMAS). The projection information for this file is GCS WGS 1984."   #probably we should agree to add the crs variable to give projection

DATE_CREATED="2014-02-01"   #need to check when it was original created
CREATOR_NAME="John Abatzoglou";
CREATOR_URL="http://climate.nkn.uidaho.edu/MACA/";
CREATOR_ROLE="Principal Investigator";
CREATOR_EMAIL="jabatzoglou@uidaho.edu";
#INSTITUTION="University of Idaho";
PROJECT="Regional Approaches to Climate Change(REACCH)";
PROCESSING_LEVEL="Gridded Climate Projections";
ACKNOWLEDGMENT="Please reference the Northwest Climate Science Center (NW CSC) US Geological Survey Grant Number G12AC20495 and the Regional Approaches to Climate Change (REACCH) USDA-NIFA Grant Number 2011-68002-30191 and the references included herein. We acknowledge the World Climate Research Programme's Working Group on Coupled Modeling, which is responsible for CMIP, and we thank the climate modeling groups for producing and making available their model output. For CMIP, the U.S. Department of Energy's Program for Climate Model Diagnosis and Intercomparison provides coordinating support and led development of software infrastructure in partnership with the Global Organization for Earth System Science Portals."

#hard coded below
#GEOSPATIAL_LAT_MIN=25.2
#GEOSPATIAL_LAT_MAX=49.4
#GEOSPATIAL_LON_MIN=-103
#GEOSPATIAL_LON_MAX=-125
#GEOSPATIAL_VERTICAL_MIN=0
#GEOSPATIAL_VERTICAL_MAX=0

#these vary depending on the file, but this will have to be done file specific
#TIME_COVERAGE_START='1950-01-01T00:00';
#TIME_COVERAGE_END='2099-12-31T00:00'
#TIME_COVERAGE_DURATION='P10Y';    #for most files except end ones
TIME_COVERAGE_RESOLUTION='P1D';

STANDARD_NAME_VOCABULARY="CF-1.0";
LICENSE="Creative Commons CC0 1.0 Universal Dedication(http://creativecommons.org/publicdomain/zero/1.0/legalcode)";
#LICENSE URI='http://creativecommons.org/publicdomain/zero/1.0/legalcode'

#=============
#  SUGGESTED 
#=============
CONTRIBUTOR_NAME="Katherine Hegewisch";
CONTRIBUTOR_ROLE="Postdoctoral Fellow";
CONTRIBUTOR_EMAIL="khegewisch@uidaho.edu";
PUBLISHERNAME="Northwest Knowledge Network"
PUBLISHEREMAIL="info@northwestknowledge.net"
PUBLISHERURL="http://www.northwestknowledge.net"

DATE_MODIFIED="2015-02-13";
DATE_ISSUED="2015-02-13";

GEOSPATIAL_LAT_UNITS="decimal degrees north";
GEOSPATIAL_LON_UNITS="decimal degrees east";
#GEOSPATIAL_LAT_RESOLUTION=0.0417
#GEOSPATIAL_LON_RESOLUTION=0.0417 #hardcoded
GEOSPATIAL_VERTICAL_UNITS="None";
GEOSPATIAL_VERTICAL_RESOLUTION=0 #hardcoded
GEOSPATIAL_VERTICAL_POSITIVE="Up";


GRID="WGS 1984"
REFERENCES="(1)  Abatzoglou, J.T, and Brown T.J. (2012), A comparison of statistical downscaling methods suited for wildfire applications, Int. J. Climatol. [doi:10.1002/joc.2312],(2) Abatzoglou, J.T. (2011) Development of gridded surface meteorological data for ecological applications and modelling " International Journal of Climatology. [doi: 10.1002/joc.3413]";



#========================================================
#    PERFORM REPLACEMENTS USING NCL
#========================================================
MODELS=("bcc-csm1-1" "bcc-csm1-1-m" "BNU-ESM" "CanESM2" "CCSM4" "CNRM-CM5" "CSIRO-Mk3-6-0" "inmcm4" "MIROC5" "GFDL-ESM2G" "GFDL-ESM2M" "HadGEM2-ES365" "HadGEM2-CC365" "IPSL-CM5B-LR" "IPSL-CM5A-MR" "IPSL-CM5A-LR" "MRI-CGCM3" "MIROC-ESM" "MIROC-ESM-CHEM" "NorESM1-M" "HadGEM2-CC" "HadGEM2-ES")

MODELNAME=(
"Beijing Climate Center, China Meteorological Administration"
"Beijing Climate Center, China Meteorological Administration"
"Canadian Centre for Climate Modelling and Analysis"
"College of Global Change and Earth System Science, Beijing Normal University"
"National Center for Atmospheric Research"
"Centre National de Recherches Météorologiques /Centre Européen de Recherche et Formation Avancées en Calcul Scientifique"
"Commonwealth Scientific and Industrial Research Organization in collaboration with Queensland Climate Change Centre of Excellence"
"Institute for Numerical Mathematics"
"Atmosphere and Ocean Research Institute (The University of Tokyo), National Institute for Environmental Studies, and Japan Agency for Marine-Earth Science and Technology"
"NOAA Geophysical Fluid Dynamics Laboratory"
"NOAA Geophysical Fluid Dynamics Laboratory"
"Met Office Hadley Centre" 
"Met Office Hadley Centre"
"Institute Pierre-Simon Laplace"
"Institute Pierre-Simon Laplace"
"Institute Pierre-Simon Laplace"
"Meteorological Research Institute"
"Japan Agency for Marine-Earth Science and Technology, Atmosphere and Ocean Research Institute (The University of Tokyo), and National Institute for Environmental Studies"
"Japan Agency for Marine-Earth Science and Technology, Atmosphere and Ocean Research Institute (The University of Tokyo), and National Institute for Environmental Studies"
"Norwegian Climate Centre"
"Met Office Hadley Centre" 
"Met Office Hadley Centre" 
)


$modelnum=0
for model in "${MODELS[@]}"
do
        cd "$model"
        $modelnum=$modelnum+1;
        $modelname=MODELNAME($modelnum)
	echo $modelname

	$runnum="1"
        if["$model" -eq "CCSM4"]
        then
                $runnum="6"
        fi


 	#=============
        #  HIGHLY RECOMMENDED 
        #=============
        for i in *.nc;do
                ncatted -O -h -a title,global,m,c,"$TITLE" $i
        done

        for i in *daily.nc;do
                ncatted -O -h -a summary,global,m,c,"$DAILYSUMMARY" $i
                ncatted -O -h -a history,global,m,c,"$DAILYHISTORY" $i
        done

        for i in *monthly.nc;do
                ncatted -O -h -a summary,global,m,c,"$MONTHLYSUMMARY" $i
                ncatted -O -h -a history,global,m,c,"$MONTHLYHISTORY" $i
        done


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
                #  REMOVE EXTRA ATTRIBUTES NOT NEEDED
                #=============
                #ncatted -O -h -a description,global,d,, $i
                #ncatted -O -h -a comment,,d,, $i
                #ncatted -O -h -a institution,global,d,, $i   #replacing with creator_institution
                #ncatted -O -h -a Metadata_Conventions,global,d,, $i
                #ncatted -O -h -a Metadata_Link,global,d,, $i
                #ncatted -O -h -a NCO,global,d,, $i    #did this come from NCO commands?

		#=============
		#  HIGHLY RECOMMENDED 
		#=============
                #ncatted -O -h -a title,global,m,c,"$TITLE" $i
                #ncatted -O -h -a summary,global,m,c,"$SUMMARY" $i
                ncatted -O -h -a keywords,global,m,c,"$KEYWORDS" $i

		#=============
		#  RECOMMENDED 
		#=============
                ncatted -O -h -a id,global,m,c,"$ID" $i
                ncatted -O -h -a naming_authority,global,m,c,"$NAMINGAUTHORITY" $i
                ncatted -O -h -a keywords_vocabulary,global,m,c,"$KEYWORDS_VOCABULARY" $i
                ncatted -O -h -a cdm_data_type,global,m,c,"$CDM_DATA_TYPE" $i
                #ncatted -O -h -a history,global,m,c,"$HISTORY" $i
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
 		ncatted -O -h -a geospatial_lat_min,global,m,f,31.0214 $i
                ncatted -O -h -a geospatial_lat_max,global,m,f,49.3960 $i
                ncatted -O -h -a geospatial_lon_min,global,m,f,-103.0225 $i
                ncatted -O -h -a geospatial_lon_max,global,m,f,-124.7720 $i
                ncatted -O -h -a geospatial_vertical_min,global,m,f,0 $i
                ncatted -O -h -a geospatial_vertical_max,global,m,f,0 $i

                ncatted -O -h -a standard_name_vocabulary,global,m,c,"$STANDARD_NAME_VOCABULARY" $i
                ncatted -O -h -a license,global,m,c,"$LICENSE" $i

  		#ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                #ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
  		#ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
                #ncatted -O -h -a time_coverage_resolution,global,m,c,"$TIME_COVERAGE_RESOLUTION" $i

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

                ncatted -O -h -a geospatial_lat_units,global,m,c,"$GEOSPATIAL_LAT_UNITS" $i
                ncatted -O -h -a geospatial_lat_resolution,global,m,f,0.0417 $i
                ncatted -O -h -a geospatial_lon_units,global,m,c,"$GEOSPATIAL_LON_UNITS" $i
                ncatted -O -h -a geospatial_lon_resolution,global,m,f,0.0417 $i
                ncatted -O -h -a geospatial_vertical_units,global,m,c,"$GEOSPATIAL_VERTICAL_UNITS" $i
                ncatted -O -h -a geospatial_vertical_resolution,global,m,f,0 $i
                ncatted -O -h -a geospatial_vertical_positive,global,m,c,"$GEOSPATIAL_VERTICAL_POSITIVE" $i

		 #extra from VIC/ULM ... crs technically covers this projection info
                ncatted -O -h -a grid,global,c,c,"$GRID" $i
                ncatted -O -h -a references,global,c,c,"$REFERENCES" $i


                #modify time long_name, standard_name
                ncatted -O -h -a standard_name,time,c,c,"time" $i
                ncatted -O -h -a long_name,time,c,c,"time" $i

                ncatted -O -h -a Conventions,global,c,c,"$CONVENTIONS" $i


        done
	#=============
        #   MODIFY DATES SPECIFIC TO THE FILE
        #=============
        for i in *daily.nc;do
                TIME_COVERAGE_RESOLUTION="P1D";
                ncatted -O -h -a time_coverage_resolution,global,m,c,"$TIME_COVERAGE_RESOLUTION" $i
        done
        for i in *monthly.nc;do
                TIME_COVERAGE_RESOLUTION="P1M";
                ncatted -O -h -a time_coverage_resolution,global,m,c,"$TIME_COVERAGE_RESOLUTION" $i
        done
        for i in *1950_1959*.nc;do
                TIME_COVERAGE_DURATION="P10Y";  #for most files except end ones
                TIME_COVERAGE_START="1950-01-01T00:00";
                TIME_COVERAGE_END="1959-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done
	for i in *1960_1969*.nc;do
                TIME_COVERAGE_DURATION="P10Y";  #for most files except end ones
                TIME_COVERAGE_START="1960-01-01T00:00";
                TIME_COVERAGE_END="1969-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done
        for i in *1970_1979*.nc;do
                TIME_COVERAGE_DURATION="P10Y";  #for most files except end ones
                TIME_COVERAGE_START="1970-01-01T00:00";
                TIME_COVERAGE_END="1979-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done
        for i in *1980_1989*.nc;do
                TIME_COVERAGE_DURATION="P10Y";  #for most files except end ones
                TIME_COVERAGE_START="1980-01-01T00:00";
                TIME_COVERAGE_END="1989-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done
        for i in *1990_1999*.nc;do
                TIME_COVERAGE_DURATION="P10Y";  #for most files except end ones
                TIME_COVERAGE_START="1990-01-01T00:00";
                TIME_COVERAGE_END="1999-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done
        for i in *2000_2005*.nc;do
                TIME_COVERAGE_DURATION="P6Y";  #for most files except end ones
                TIME_COVERAGE_START="2000-01-01T00:00";
                TIME_COVERAGE_END="2005-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done
	for i in *2006_2015*.nc;do
                TIME_COVERAGE_DURATION="P10Y";  #for most files except end ones
                TIME_COVERAGE_START="2006-01-01T00:00";
                TIME_COVERAGE_END="2015-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done
	for i in *2016_2025*.nc;do
                TIME_COVERAGE_DURATION="P10Y";  #for most files except end ones
                TIME_COVERAGE_START="2016-01-01T00:00";
                TIME_COVERAGE_END="2025-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done
        for i in *2026_2035*.nc;do
                TIME_COVERAGE_DURATION="P10Y";  #for most files except end ones
                TIME_COVERAGE_START="2026-01-01T00:00";
                TIME_COVERAGE_END="2035-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done
        for i in *2036_2045*.nc;do
                TIME_COVERAGE_DURATION="P10Y";  #for most files except end ones
                TIME_COVERAGE_START="2036-01-01T00:00";
                TIME_COVERAGE_END="2045-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done
        for i in *2046_2055*.nc;do
                TIME_COVERAGE_DURATION="P10Y";  #for most files except end ones
                TIME_COVERAGE_START="2046-01-01T00:00";
                TIME_COVERAGE_END="2055-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done
        for i in *2056_2065*.nc;do
                TIME_COVERAGE_DURATION="P10Y";  #for most files except end ones
                TIME_COVERAGE_START="2056-01-01T00:00";
                TIME_COVERAGE_END="2065-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done
        for i in *2066_2075*.nc;do
                TIME_COVERAGE_DURATION="P10Y";  #for most files except end ones
                TIME_COVERAGE_START="2066-01-01T00:00";
                TIME_COVERAGE_END="2075-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done
        for i in *2076_2085*.nc;do
                TIME_COVERAGE_DURATION="P10Y";  #for most files except end ones
                TIME_COVERAGE_START="2076-01-01T00:00";
                TIME_COVERAGE_END="2085-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done
        for i in *2086_2095*.nc;do
                TIME_COVERAGE_DURATION="P10Y";  #for most files except end ones
                TIME_COVERAGE_START="2086-01-01T00:00";
                TIME_COVERAGE_END="2095-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done
        for i in *2096_2100*.nc;do
                TIME_COVERAGE_DURATION="P5Y";  #for most files except end ones
                TIME_COVERAGE_START="2086-01-01T00:00";
                TIME_COVERAGE_END="2100-12-31T00:00";
                ncatted -O -h -a time_coverage_start,global,m,c,"$TIME_COVERAGE_START" $i
                ncatted -O -h -a time_coverage_end,global,m,c,"$TIME_COVERAGE_END" $i
                ncatted -O -h -a time_coverage_duration,global,m,c,"$TIME_COVERAGE_DURATION" $i
        done

        cd ../
done

