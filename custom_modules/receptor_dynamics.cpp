#include "./receptor_dynamics.h" 

using namespace PhysiCell; 

std::string receptor_model_version = "0.4.0"; 

Submodel_Information receptor_dynamics_info; 

void simple_receptor_dynamics_model_setup(void)
{

	// set version 
	receptor_dynamics_info.name = "receptor dynamics"; 
	receptor_dynamics_info.version = receptor_model_version; 
	// set functions 
	/*
	receptor_dynamics_info.main_function = simple_receptor_dynamics_main_model; 
	receptor_dynamics_info.phenotype_function = NULL; // pushed into the "main" model  
	receptor_dynamics_info.mechanics_function = NULL; 	
	*/
	
	receptor_dynamics_info.main_function = NULL; 
	receptor_dynamics_info.phenotype_function = simple_receptor_dynamics_model; // pushed into the "main" model  
	receptor_dynamics_info.mechanics_function = NULL; 
	
	// what microenvironment variables do you need 
	receptor_dynamics_info.microenvironment_variables.push_back( "virion" ); 	
	receptor_dynamics_info.microenvironment_variables.push_back( "interferon 1" ); 	
	
	// what custom data do I need? 
	receptor_dynamics_info.cell_variables.push_back( "VAtthi" ); 
	receptor_dynamics_info.cell_variables.push_back( "VAttlo" ); 
	receptor_dynamics_info.cell_variables.push_back( "Bhi" ); 	
	receptor_dynamics_info.cell_variables.push_back( "Blo" ); 	
	receptor_dynamics_info.cell_variables.push_back( "VEn" ); 	
	
	// submodel_registry.register_model( receptor_dynamics_info ); 
	receptor_dynamics_info.register_model(); 
	
	return;
}


void simple_receptor_dynamics_model( Cell* pCell, Phenotype& phenotype, double dt )
{
	
	// if cell is dead, no virus binding
	if( phenotype.death.dead == true )
	{ return; } 

	static int lung_epithelial_type = get_cell_definition( "lung epithelium" ).type; 
	// if not lung epithelium, do not execute this binding model
	if( pCell->type != lung_epithelial_type )
	{ return; } 
	
	
	//****************************************************************
	int virus_index = microenvironment.find_density_index( "virion" ); 
	
	double Vvoxel = microenvironment.mesh.voxels[1].volume;
	double rho = pCell->nearest_density_vector()[virus_index];
	double m = pCell->phenotype.molecular.internalized_total_substrates[virus_index];
	double mhalf = parameters.doubles("mhalf");
	double rhomax = parameters.doubles("rhomax");
		
	
	if(rho*Vvoxel>1)//0) // if density of virus oustide cell is non-negative value or greater than 1 virion
	{
		//std::cout<<"New uptake rate: "<<pCell->phenotype.secretion.uptake_rates[virus_index]<<std::endl;
		
		if(rho<rhomax/Vvoxel)
		{
			pCell->phenotype.secretion.uptake_rates[virus_index] = parameters.doubles("uEvirus")*(mhalf/(m/Vvoxel+mhalf/Vvoxel));
		
		}
		else
		{
			pCell->phenotype.secretion.uptake_rates[virus_index] = parameters.doubles("uEvirus")*(rhomax/Vvoxel/rho)*(mhalf/(m/Vvoxel+mhalf/Vvoxel));
		}
	}
	else // density of virus outside the cell was negative and so no receptor binding occurs
	{pCell->phenotype.secretion.uptake_rates[virus_index]=0;}
	
	
		
	return;
}

void simple_receptor_dynamics_main_model( double dt )
{
	#pragma omp parallel for 
	for( int n=0; n < (*all_cells).size() ; n++ )
	{
		Cell* pC = (*all_cells)[n]; 
		if( pC->phenotype.death.dead == false )
		{ 
			simple_receptor_dynamics_model( pC, pC->phenotype , dt ); 
		}
	}
	
	return; 
}
