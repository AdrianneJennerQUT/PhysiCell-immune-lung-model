% Creating movie of substrates
%addpath('../output')
var=1;
timetotal =143;
A = 'output0000000';
A2 = 'output000000';
A3 = 'output00000'; 
A4 = 'output0000'; 
B = '.xml';
virus_index = 1;
IFN_index = 2;
pro_cyto_index = 3;
chemokine_index = 4;
debris_index = 5;
ROS_index = 6;


voxel_vol = 20*20*20;

v = VideoWriter('sub111.avi')
v.FrameRate = 10;
open(v)
figure('Position', [50 50 900 700])
hold on 

for tcount = 2:timetotal
    clf
    if tcount<11
        K = [A num2str(tcount-1,'%d') B];
    elseif tcount<101
        K = [A2 num2str(tcount-1,'%d') B];
    elseif tcount<1001
        K = [A3 num2str(tcount-1,'%d') B];
    else
        K = [A4 num2str(tcount-1,'%d') B];
    end
    MCDS = read_MultiCellDS_xml(K,'C:/Users/adria/OneDrive - Queensland University of Technology/Documents/2022/PhysiCell_Immune_Subgroup2-main/PhysiCell_Immune_Subgroup2-main/output');
    
   % MCDS = read_MultiCellDS_xml(K);
    k = find( MCDS.mesh.Z_coordinates == 0 ); 
    
    subplot(3,2,1)
    contourf( MCDS.mesh.X(:,:,k), MCDS.mesh.Y(:,:,k), ...
    MCDS.continuum_variables(virus_index).data(:,:,k) , 20 ) ;
    axis image;
    colorbar; 
    xlabel( sprintf( 'x (%s)' , MCDS.metadata.spatial_units) ); 
    ylabel( sprintf( 'y (%s)' , MCDS.metadata.spatial_units) ); 
     title( sprintf('%s (%s) at t = %3.2f %s', MCDS.continuum_variables(virus_index).name , ...
     MCDS.continuum_variables(virus_index).units , ...
     MCDS.metadata.current_time , ...
     MCDS.metadata.time_units ) ); 

    subplot(3,2,2)
    contourf( MCDS.mesh.X(:,:,k), MCDS.mesh.Y(:,:,k), ...
    MCDS.continuum_variables(IFN_index).data(:,:,k) , 20 ) ;
    axis image;
    colorbar; 
    xlabel( sprintf( 'x (%s)' , MCDS.metadata.spatial_units) ); 
    ylabel( sprintf( 'y (%s)' , MCDS.metadata.spatial_units) ); 
     title( sprintf('%s (%s) at t = %3.2f %s', MCDS.continuum_variables(IFN_index).name , ...
     MCDS.continuum_variables(IFN_index).units , ...
     MCDS.metadata.current_time , ...
     MCDS.metadata.time_units ) ); 

    subplot(3,2,3)
    contourf( MCDS.mesh.X(:,:,k), MCDS.mesh.Y(:,:,k), ...
    MCDS.continuum_variables(pro_cyto_index).data(:,:,k) , 20 ) ;
    axis image;
    colorbar; 
    xlabel( sprintf( 'x (%s)' , MCDS.metadata.spatial_units) ); 
    ylabel( sprintf( 'y (%s)' , MCDS.metadata.spatial_units) ); 
    title( sprintf('%s (%s) at t = %3.2f %s', MCDS.continuum_variables(pro_cyto_index).name , ...
     MCDS.continuum_variables(pro_cyto_index).units , ...
     MCDS.metadata.current_time , ...
     MCDS.metadata.time_units ) ); 

    subplot(3,2,4)
    contourf( MCDS.mesh.X(:,:,k), MCDS.mesh.Y(:,:,k), ...
    MCDS.continuum_variables(chemokine_index).data(:,:,k) , 20 ) ;
    axis image;
    colorbar; 
    xlabel( sprintf( 'x (%s)' , MCDS.metadata.spatial_units) ); 
    ylabel( sprintf( 'y (%s)' , MCDS.metadata.spatial_units) ); 
     title( sprintf('%s (%s) at t = %3.2f %s', MCDS.continuum_variables(chemokine_index).name , ...
     MCDS.continuum_variables(chemokine_index).units , ...
     MCDS.metadata.current_time , ...
     MCDS.metadata.time_units ) ); 

    subplot(3,2,5)
    contourf( MCDS.mesh.X(:,:,k), MCDS.mesh.Y(:,:,k), ...
    MCDS.continuum_variables(debris_index).data(:,:,k) , 20 ) ;
    axis image;
    colorbar; 
    xlabel( sprintf( 'x (%s)' , MCDS.metadata.spatial_units) ); 
    ylabel( sprintf( 'y (%s)' , MCDS.metadata.spatial_units) ); 
    title( sprintf('%s (%s) at t = %3.2f %s', MCDS.continuum_variables(debris_index).name , ...
     MCDS.continuum_variables(debris_index).units , ...
     MCDS.metadata.current_time , ...
     MCDS.metadata.time_units ) ); 

    subplot(3,2,6)
    contourf( MCDS.mesh.X(:,:,k), MCDS.mesh.Y(:,:,k), ...
    MCDS.continuum_variables(ROS_index).data(:,:,k) , 20 ) ;
    axis image;
    colorbar; 
    xlabel( sprintf( 'x (%s)' , MCDS.metadata.spatial_units) ); 
    ylabel( sprintf( 'y (%s)' , MCDS.metadata.spatial_units) ); 
    title( sprintf('%s (%s) at t = %3.2f %s', MCDS.continuum_variables(ROS_index).name , ...
     MCDS.continuum_variables(ROS_index).units , ...
     MCDS.metadata.current_time , ...
     MCDS.metadata.time_units ) ); 
    
 virus_index = 1;
IFN_index = 2;
pro_cyto_index = 3;
chemokine_index = 4;
debris_index = 5;
ROS_index = 6;
 	 virus(tcount) = sum(sum(MCDS.continuum_variables(virus_index).data(:,:,k)));
 	 IFN(tcount) = sum(sum(MCDS.continuum_variables(IFN_index).data(:,:,k)));
 	 chemokine(tcount) = sum(sum(MCDS.continuum_variables(chemokine_index).data(:,:,k)));
 	 pro_cyto(tcount) = sum(sum(MCDS.continuum_variables(pro_cyto_index).data(:,:,k)));
 	 debris(tcount) = sum(sum(MCDS.continuum_variables(debris_index).data(:,:,k)));
 	ROS(tcount) = sum(sum(MCDS.continuum_variables(ROS_index).data(:,:,k)));
 
  
  epi_index = 1;
  cd8_index = 3;
  mac_index = 4;
  neu_index = 5;
  DC_index = 6;
  cd4_index = 7;
 
  epi_tot(tcount) = length(find( MCDS.discrete_cells.metadata.type == epi_index));
  
  % small volume cells
  index_cells_small_vol = find(MCDS.discrete_cells.phenotype.geometrical_properties.volumes.total_volume<1);

  % dead cells
  tot_dead_cells(tcount) = length(MCDS.discrete_cells.dead_cells);
  index_cells_dead_and_small_vol = intersect(MCDS.discrete_cells.dead_cells,index_cells_small_vol);
  tot_dead_cells_vol_over_1(tcount) = tot_dead_cells(tcount)-length(index_cells_dead_and_small_vol);

  % total dead epi cells
  index_epi_cells_dead = find(MCDS.discrete_cells.metadata.type(MCDS.discrete_cells.dead_cells) == epi_index);
  index_epi_cells_dead_vol_under_1 = intersect(index_epi_cells_dead,index_cells_dead_and_small_vol);
  index_dead_cells = MCDS.discrete_cells.dead_cells;
  index_cells_suf_vol = find(MCDS.discrete_cells.phenotype.geometrical_properties.volumes.total_volume>1);
  index_epi_cells = find( MCDS.discrete_cells.metadata.type == epi_index);

  AA = intersect(index_dead_cells,index_cells_suf_vol);
  epi_dead(tcount) =length(intersect(AA,index_epi_cells));
  
  %total live cells
  index_live_cells = MCDS.discrete_cells.live_cells;

  %total live epi cells
  epi_live(tcount) = length(find(MCDS.discrete_cells.metadata.type(index_live_cells) == epi_index));
  
  %total live epi cells that are infected
  index_vnuc_over_1 = find(MCDS.discrete_cells.custom.Vnuc(MCDS.discrete_cells.live_cells)*voxel_vol>1);
  index_epi_live = find(MCDS.discrete_cells.metadata.type(MCDS.discrete_cells.live_cells) == epi_index);
  epi_live_infected(tcount) = length(intersect(index_vnuc_over_1,index_epi_live));

  %total epi live uninfected
  epi_live_uninfected(tcount) = epi_live(tcount)-epi_live_infected(tcount);

  %total immune cells
  CD8_tot_index = find(MCDS.discrete_cells.metadata.type == cd8_index);
  cd8_tot(tcount) = length(CD8_tot_index);
 
  mac_tot_index = find(MCDS.discrete_cells.metadata.type == mac_index);
  mac_tot(tcount) = length(mac_tot_index);

  neu_tot_index = find(MCDS.discrete_cells.metadata.type == neu_index);
  neu_tot(tcount) = length(neu_tot_index);

  DC_tot_index = find(MCDS.discrete_cells.metadata.type == DC_index);
  DC_tot(tcount) = length(DC_tot_index);

  cd4_tot_index = find(MCDS.discrete_cells.metadata.type == cd4_index);
  cd4_tot(tcount) = length(cd4_tot_index);


 %determining the total immune cells that are alive
 live_cells_index = MCDS.discrete_cells.live_cells;
 cd8_live(tcount) = length(find(MCDS.discrete_cells.metadata.type(MCDS.discrete_cells.live_cells) == cd8_index));
 mac_live(tcount) = length(find(MCDS.discrete_cells.metadata.type(MCDS.discrete_cells.live_cells) == mac_index));
 neu_live(tcount) = length(find(MCDS.discrete_cells.metadata.type(MCDS.discrete_cells.live_cells) == neu_index));
 DC_live(tcount) = length(find(MCDS.discrete_cells.metadata.type(MCDS.discrete_cells.live_cells) == DC_index));
 cd4_live(tcount) = length(find(MCDS.discrete_cells.metadata.type(MCDS.discrete_cells.live_cells) == cd4_index));

 frame = getframe(gcf);
 writeVideo(v,frame);
    

end
close(v)

%% substrate totals
time_grid = linspace(0,143*120/60/24,143);

figure
hold on
subplot(3,2,1)
plot(time_grid,virus*voxel_vol,'Color',[45 50 147]/255,'LineWidth',2)
ylabel('Virion')
xlabel('Time (hours)')
set(gca,'FontSize',14)
subplot(3,2,2)
plot(time_grid,IFN*voxel_vol,'--','Color',[134 184 215]/255,'LineWidth',2)
xlabel('Time (hours)')
set(gca,'FontSize',14)
ylabel('IFN')
subplot(3,2,3)
plot(time_grid,chemokine*voxel_vol,'--','Color',[188 181 216]/255,'LineWidth',2)
xlabel('Time (hours)')
set(gca,'FontSize',14)
ylabel('chemokine')
subplot(3,2,4)
plot(time_grid,pro_cyto*voxel_vol,'Color',[92 47 141]/255,'LineWidth',2)
xlabel('Time (hours)')
set(gca,'FontSize',14)
ylabel('cytokine')
subplot(3,2,5)
plot(time_grid,debris*voxel_vol,':','Color',[217 167 249]/255,'LineWidth',2)
xlabel('Time (hours)')
set(gca,'FontSize',14)
ylabel('debris')
subplot(3,2,6)
plot(time_grid,ROS*voxel_vol,'Color',[210 61 118]/255,'LineWidth',2)
xlabel('Time (hours)')
ylabel('ROS')
set(gca,'FontSize',14)
 saveas(gcf,'FZERO.png')


 figure
 yyaxis left
 hold on
plot(time_grid,virus*voxel_vol,'Color',[45 50 147]/255,'LineWidth',2)
xlabel('Time (days)')
set(gca,'FontSize',18)
ylabel('virus')
yyaxis right
plot(time_grid,IFN*voxel_vol,'--','Color',[134 184 215]/255,'LineWidth',2)
ylabel('IFN')

 figure
 yyaxis left
 hold on
plot(time_grid,chemokine*voxel_vol,'--','Color',[188 181 216]/255,'LineWidth',2)
plot(time_grid,pro_cyto*voxel_vol,'Color',[92 47 141]/255,'LineWidth',2)
xlabel('Time (days)')
set(gca,'FontSize',18)
ylabel('cytokine and chemo.')
yyaxis right
plot(time_grid,debris*voxel_vol,':','Color',[217 167 249]/255,'LineWidth',2)
plot(time_grid,ROS*voxel_vol,'Color',[210 61 118]/255,'LineWidth',2)
ylabel('debris and ROS')

%% cell count totals

figure
yyaxis left
hold on
plot(time_grid(2:end),epi_live_uninfected(2:end),'Color',[171 19 53]/255,'LineWidth',2)
ylim([1.6e5 1.8e5])
ylabel('Live uninfected epi cells')
yyaxis right
hold on
plot(time_grid,epi_dead,':','Color',[253 181 110]/255,'LineWidth',2)
plot(time_grid,epi_live_infected,'--','Color',[244 110 68]/255,'LineWidth',2)
legend('epi live','tot dead','epi live infected')
set(gca,'FontSize',18)
xlabel('Time (days)')
ylabel('Dead and infected epi cells')

xlim([0 15])

%%
figure
hold on
yyaxis left
plot(time_grid,mac_live,'Color',[9 102 53]/255,'LineWidth',2)
plot(time_grid,neu_live,'--','Color',[121 197 119]/255,'LineWidth',2)
plot(time_grid,DC_live,':','Color',[203 232 102]/255,'LineWidth',2)
ylabel('Macs, neuts and DCS')
yyaxis right
hold on
plot(time_grid,cd8_live,'Color',[253 171 90]/255,'LineWidth',2)
plot(time_grid,cd4_live,':','Color',[249 207 88]/255,'LineWidth',2)
set(gca,'FontSize',18)
xlabel('Time (days)')
ylabel('CD8 and CD4 cells')
xlim([0 15])