clear;clc;clf;
mesh_size=[1,0.8,0.6,0.4,0.2,0.1,0.09,0.08,0.07,0.06,0.05];
stress_bottom_linear=[1841748.763691068,1808704.445098145,1839061.2902862402,1849796.2370138424,1853423.9357566386,1995514.1479006587,2007870.8571776375,2007966.4227142376,2055038.3199845303,2082069.6536937053,2100849.0505507197];
stress_top_linear=[1748479.2222075108,1796872.585745627,1845964.3583432245,1867982.5771400654,1875991.7160239983,2009379.9379270794,1988852.2712724223,2039319.0828992566,2053232.3105243926,2074633.9249254619,2089762.9506780556];
stress_bottom_quadratic=[2167488.602128598,2180214.3874495397,2161315.022139212,2162752.0227312427,2180394.3413553135,2180666.8825000124,2165360.7658757763,2176054.460092674,2177072.6807441316,2170251.2651596237,2178319.3628314324];
stress_top_quadratic=[2165049.6578678736,2162995.3342932314,2179220.6928569935,2167342.210334764,2185836.5635893256,2178696.0333066843,2176277.9766859855,2176908.6413807524,2177319.370331657,2170861.9087515166,2180696.8409166075];
semilogx(mesh_size,stress_bottom_linear,'b.-')
hold on 
grid on
semilogx(mesh_size,stress_top_linear,'b.--')
semilogx(mesh_size,stress_bottom_quadratic,'r.-')
semilogx(mesh_size,stress_top_quadratic,'r.--')
title('plot of maximum von Mises stress vs. mesh size')
xlabel('mesh size/m');
ylabel('von Mises stress/(N/m^2)');
stress_bottom_linear_d2=[1809310.1431722546,1849796.2370138424,1785630.8382107525,1853423.9357566386,1995514.1479006633,2100849.0505506513,2111483.4494801066,2121892.2118980857,2134192.2121019303,2138853.7056746744,2149404.70531952];
stress_bottom_linear_d3=[1850037.3149339438,1827977.4833921075,1823975.1229514377,1897736.004041194,2067036.17401424,2135548.4221123094,2138853.705674623,2145966.7019352717,2151677.417247089,2156200.5842248066,2160112.5629322426];
semilogx(mesh_size,stress_bottom_linear_d2,'g.-')
semilogx(mesh_size,stress_bottom_linear_d3,'m.-')
legend('stress-bottom-linear','stress-top-linear','stress-bottom-quadratic','stress-top-quadratic','stress-bottom-linear-d2','stress-bottom-linear-d3');