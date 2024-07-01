within ;
package DQLVentilation
  model newfbs
     package Medium = Buildings.Media.Air;
     parameter Real G_p=654603*60 "PM generation rate for each person";
     parameter Real C_x=10^9 "PM concentration of the fresh air";
     parameter Real eta_z=0.95 "total filter efficiency";
     parameter Real eta_hp=0.9997 "filter efficiency of the inlet air";

    // parameter Real Q_h=res4.m_flow+res8.m_flow+res6.m_flow "Return air mass flow";
     parameter Real D=0 "PM dropt rate";

     Real C1 "PM concteration of the bio test room";
     Real C2 "PM concteration of the no-germ room";
     Real C3 "PM concteration of the huanchong room";
     Real C_s "pm of supply air";
     Real C_h "PM concentration of the return air";
     Real Q_h "Return air mass flow";
     Real G_s_1= G_p*combiTimeTable.y[2] "pm diffusion source per min";
     Real G_s_2= G_p*combiTimeTable.y[3] "pm diffusion source per min";
     Real G_s_3= G_p*combiTimeTable.y[4] "pm diffusion source per min";

    Buildings.Fluid.Sources.Boundary_pT sinAir1(
      nPorts=1,
      redeclare package Medium = Medium,
      p(displayUnit="bar") = 100000,
      T=293.15) "Sink for water circuit"
      annotation (Placement(transformation(extent={{-104,60},{-84,80}})));
    Buildings.Fluid.Movers.FlowControlled_m_flow fan11(
      addPowerToMedium=false,
      redeclare package Medium = Medium,
      dp_nominal=1900,
      m_flow_nominal=0.7034)                      annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={-28,72})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=100,
      m_flow_nominal=0.237)
                         annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={-10,-14})));
    Buildings.Fluid.MixingVolumes.MixingVolume GasRoom(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      m_flow_nominal=10,
      nPorts=8,
      T_start=273.15 + 20,
      V=17.82,
      redeclare package Medium = Medium,
      p_start(displayUnit="bar"))
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={14,-28})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp1(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      m_flow_nominal=0.235,
      dpDamper_nominal=100,
      riseTime=100)      annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={-8,-46})));
    Buildings.Fluid.Sources.Boundary_pT sinAir2(
      redeclare package Medium = Medium,
      nPorts=6,
      p(displayUnit="bar") = 100000,
      T=293.15) "Sink for water circuit"
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=-90,
          origin={38,-110})));
    Buildings.Fluid.FixedResistances.PressureDrop res1(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=500,
      m_flow_nominal=0.06)
      annotation (Placement(transformation(extent={{-72,66},{-60,78}})));
    Buildings.Fluid.FixedResistances.PressureDrop res0(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=30,
      m_flow_nominal=0.0136)
      annotation (Placement(transformation(extent={{2,-52},{12,-40}})));
    Buildings.Fluid.FixedResistances.PressureDrop res2(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=900,
      m_flow_nominal=0.704)
      annotation (Placement(transformation(extent={{-52,66},{-40,78}})));
    Buildings.Fluid.MixingVolumes.MixingVolume GasRoom1(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      m_flow_nominal=10,
      nPorts=8,
      T_start=273.15 + 20,
      redeclare package Medium = Medium,
      p_start(displayUnit="bar"),
      V=18.6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={70,-32})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp2(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=3,
      m_flow_nominal=0.24)
                         annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={52,-14})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp3(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      m_flow_nominal=0.214,
      riseTime=3)        annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=90,
          origin={50,-54})));
    Buildings.Fluid.FixedResistances.PressureDrop res01(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=40,
      m_flow_nominal=0.0142)
      annotation (Placement(transformation(extent={{62,-52},{72,-40}})));
    Buildings.Fluid.FixedResistances.PressureDrop res3(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=370,
      m_flow_nominal=0.237)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={-8,64})));
    Buildings.Fluid.FixedResistances.PressureDrop res4(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=430,
      m_flow_nominal=0.235)
                           annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={-44,-56})));
    Buildings.Fluid.FixedResistances.PressureDrop res5(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=360,
      m_flow_nominal=0.24)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={12,64})));
    Buildings.Fluid.FixedResistances.PressureDrop res6(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=440,
      m_flow_nominal=0.214)
                           annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={-44,-68})));
    Buildings.Fluid.MixingVolumes.MixingVolume GasRoom2(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      m_flow_nominal=10,
      nPorts=8,
      T_start=273.15 + 20,
      redeclare package Medium = Medium,
      p_start(displayUnit="bar"),
      V=21.1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={58,34})));
    Buildings.Fluid.FixedResistances.PressureDrop res7(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=365,
      m_flow_nominal=0.227)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={28,64})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp4(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=180,
      m_flow_nominal=0.227)
                         annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=90,
          origin={28,46})));
    Buildings.Fluid.FixedResistances.PressureDrop res02(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=35,
      m_flow_nominal=0.032)
      annotation (Placement(transformation(extent={{66,12},{76,24}})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp5(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=180,
      m_flow_nominal=0.195)
                         annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={28,22})));
    Buildings.Airflow.Multizone.Orifice ori(redeclare package Medium = Medium, A=0.004222)
      annotation (Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={0,4})));
    Buildings.Airflow.Multizone.Orifice ori1(redeclare package Medium = Medium, A=
          0.004222)
               annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=-90,
          origin={56,4})));
    Buildings.Airflow.Multizone.Orifice ori5(redeclare package Medium = Medium, A=
          0.00078)
               annotation (Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=180,
          origin={28,-42})));

    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,
          0.211,0,0,0; 3600,0.211,0,0,0; 7200,0.211,0,0,0; 10800,0.211,0,0,0;
          14400,0.211,0,0,0; 18000,0.211,0,0,0; 21600,0.211,0,0,0; 25200,0.211,0,
          0,0; 28800,0.50508,0,0,0; 28860,0.50508,0,0,1.5; 28920,0.50508,0,0,3;
          28980,0.50508,0,0,2.5; 29040,0.50508,0,0,2.2; 29100,0.50508,0,0,1.8;
          29160,0.50508,0,0,1.7; 29220,0.50508,0,0,1.65; 30600,0.44592,0,0,0;
          30660,0.44592,0.5,1,0; 30720,0.44592,1,2,0; 30780,0.44592,0.833333333,
          1.666666667,0; 30840,0.44592,0.733333333,1.466666667,0; 30900,0.44592,
          0.6,1.2,0; 30960,0.44592,0.566666667,1.133333333,0; 31020,0.44592,0.55,
          1.1,0; 32400,0.44592,0.55,1.1,0; 36000,0.44592,0.55,1.1,0; 36060,
          0.47776,0.55,1.1,0.5; 36120,0.47776,0.55,1.1,1; 36180,0.47776,0.55,1.1,
          0.833333333; 36240,0.47776,0.55,1.1,0.733333333; 36300,0.47776,0.55,1.1,
          0.6; 36360,0.47776,0.55,1.1,0.566666667; 36420,0.47776,0.55,1.1,0.55;
          37800,0.44592,0.55,1.1,0; 39600,0.44592,0.55,1.1,0; 43200,0.6978,0,0,0;
          43260,0.50508,0,0,1.5; 43320,0.50508,0,0,3; 43380,0.50508,0,0,2.5;
          43440,0.50508,0,0,2.2; 43500,0.50508,0,0,1.8; 43560,0.50508,0,0,1.7;
          43620,0.50508,0,0,1.65; 45000,0.2532,0,0,0; 48600,0.44592,1,0.5,0;
          48660,0.44592,2,1,0; 48720,0.44592,1.666666667,0.833333333,0; 48780,
          0.44592,1.466666667,0.733333333,0; 48840,0.44592,1.2,0.6,0; 48900,
          0.44592,1.133333333,0.566666667,0; 48960,0.44592,1.1,0.55,0; 49020,
          0.44592,1.1,0.55,0; 50400,0.44592,1.1,0.55,0; 54000,0.47776,1.1,0.55,0;
          54060,0.47776,1.1,0.55,0.5; 54120,0.47776,1.1,0.55,1; 54180,0.47776,1.1,
          0.55,0.833333333; 54240,0.47776,1.1,0.55,0.733333333; 54300,0.47776,1.1,
          0.55,0.6; 54360,0.47776,1.1,0.55,0.566666667; 54420,0.47776,1.1,0.55,
          0.55; 55800,0.44592,1.1,0.55,0; 57600,0.44592,1.1,0.55,0; 61200,0.44592,
          1.1,0.55,0; 64800,0.6978,0,0,0; 64860,0.50508,0,0,1.5; 64920,0.50508,0,
          0,3; 64980,0.50508,0,0,2.5; 65040,0.50508,0,0,2.2; 65100,0.50508,0,0,
          1.8; 65160,0.50508,0,0,1.7; 65220,0.50508,0,0,1.65; 66600,0.211,0,0,0;
          68400,0.211,0,0,0; 72000,0.211,0,0,0; 75600,0.211,0,0,0; 79200,0.211,0,
          0,0; 82800,0.211,0,0,0])
      annotation (Placement(transformation(extent={{-80,86},{-60,106}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue
      annotation (Placement(transformation(extent={{-30,34},{-10,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=C3)
      annotation (Placement(transformation(extent={{-70,34},{-50,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=C1)
      annotation (Placement(transformation(extent={{-70,-12},{-50,8}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue2
      annotation (Placement(transformation(extent={{-30,-12},{-10,8}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=C2)
      annotation (Placement(transformation(extent={{112,-24},{92,-4}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue3
      annotation (Placement(transformation(extent={{80,-24},{60,-4}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{26,-86},{6,-66}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre1(redeclare package
        Medium =                                                                   Medium)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-46,-14})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre2(redeclare package
        Medium =                                                                   Medium)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={98,12})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre3(redeclare package
        Medium =                                                                   Medium)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-82,-70})));
    Buildings.Controls.Continuous.LimPID conPID(
      reverseAction=true,
      k=0.01,
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      Td=1,
      yMax=0.2,
      yMin=-0.2,
      Ti=15)
      annotation (Placement(transformation(extent={{-70,-52},{-58,-40}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=30)
      annotation (Placement(transformation(extent={{-102,-56},{-82,-36}})));
    Modelica.Blocks.Sources.RealExpression realExpression4(y=40)
      annotation (Placement(transformation(extent={{152,-66},{132,-46}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre4(
                                                       redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{70,-90},{50,-70}})));
    Modelica.Blocks.Sources.RealExpression realExpression5(y=35)
      annotation (Placement(transformation(extent={{-100,12},{-80,32}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre5(
                                                       redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-94,4})));
    Modelica.Blocks.Math.Add add
      annotation (Placement(transformation(extent={{-48,-52},{-36,-40}})));
    Modelica.Blocks.Sources.RealExpression realExpression6(y=ceil((-0.6518*((
          damExp.m_flow - 0.002)/damExp1.m_flow_nominal)*((damExp.m_flow -
          0.002)/damExp1.m_flow_nominal) + 1.5934*((damExp.m_flow - 0.002)/
          damExp1.m_flow_nominal))*10)/10)
      annotation (Placement(transformation(extent={{-102,-44},{-82,-24}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
      annotation (Placement(transformation(extent={{-28,-50},{-20,-42}})));
    Buildings.Controls.Continuous.LimPID conPID1(
      reverseAction=true,
      k=0.01,
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      Td=1,
      yMax=0.2,
      yMin=-0.2,
      Ti=15)
      annotation (Placement(transformation(extent={{114,-62},{102,-50}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{90,-60},{78,-48}})));
    Modelica.Blocks.Nonlinear.Limiter limiter1(
                                              uMax=1, uMin=0)
      annotation (Placement(transformation(extent={{70,-58},{62,-50}})));
    Modelica.Blocks.Sources.RealExpression realExpression7(y=ceil((-0.6518*((
          damExp2.m_flow - 0.026)/damExp3.m_flow_nominal)*((damExp2.m_flow -
          0.026)/damExp3.m_flow_nominal) + 1.5934*((damExp2.m_flow - 0.026)/
          damExp3.m_flow_nominal))*10)/10)
      annotation (Placement(transformation(extent={{126,-48},{106,-28}})));
    Buildings.Controls.Continuous.LimPID conPID3(
      reverseAction=true,
      k=0.01,
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      Td=1,
      yMax=0.2,
      yMin=-0.2,
      Ti=15)
      annotation (Placement(transformation(extent={{-70,16},{-58,28}})));
    Modelica.Blocks.Math.Add add2
      annotation (Placement(transformation(extent={{-46,16},{-34,28}})));
    Modelica.Blocks.Nonlinear.Limiter limiter2(
                                              uMax=1, uMin=0)
      annotation (Placement(transformation(extent={{-16,18},{-8,26}})));
    Modelica.Blocks.Sources.RealExpression realExpression8(y=ceil((-0.6518*((
          damExp4.m_flow - 0.032)/damExp5.m_flow_nominal)*((damExp4.m_flow -
          0.032)/damExp5.m_flow_nominal) + 1.5934*((damExp4.m_flow - 0.032)/
          damExp5.m_flow_nominal))*10)/10)
      annotation (Placement(transformation(extent={{-88,24},{-68,44}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_huanchong(smoothness=
          Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,0.322274882;
          3600,0.322274882; 7200,0.322274882; 10800,0.322274882; 14400,
          0.322274882; 18000,0.322274882; 21600,0.322274882; 25200,0.322274882;
          28800,0.660251841; 28860,0.660251841; 28920,0.660251841; 28980,
          0.660251841; 29040,0.660251841; 29100,0.660251841; 29160,0.660251841;
          29220,0.660251841; 30600,0.182992465; 30660,0.182992465; 30720,
          0.182992465; 30780,0.182992465; 30840,0.182992465; 30900,0.182992465;
          30960,0.182992465; 31020,0.182992465; 32400,0.182992465; 36000,
          0.182992465; 36060,0.237441393; 36120,0.237441393; 36180,0.237441393;
          36240,0.237441393; 36300,0.237441393; 36360,0.237441393; 36420,
          0.237441393; 37800,0.182992465; 39600,0.182992465; 43200,0.477901978;
          43260,0.660251841; 43320,0.660251841; 43380,0.660251841; 43440,
          0.660251841; 43500,0.660251841; 43560,0.660251841; 43620,0.660251841;
          45000,0.322274882; 48600,0.182992465; 48660,0.182992465; 48720,
          0.182992465; 48780,0.182992465; 48840,0.182992465; 48900,0.182992465;
          48960,0.182992465; 49020,0.182992465; 50400,0.182992465; 54000,
          0.237441393; 54060,0.237441393; 54120,0.237441393; 54180,0.237441393;
          54240,0.237441393; 54300,0.237441393; 54360,0.237441393; 54420,
          0.237441393; 55800,0.182992465; 57600,0.182992465; 61200,0.182992465;
          64800,0.477901978; 64860,0.660251841; 64920,0.660251841; 64980,
          0.660251841; 65040,0.660251841; 65100,0.660251841; 65160,0.660251841;
          65220,0.660251841; 66600,0.322274882; 68400,0.322274882; 72000,
          0.322274882; 75600,0.322274882; 79200,0.322274882; 82800,0.322274882])
      annotation (Placement(transformation(extent={{90,78},{74,94}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_huanchong_weisheng(
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,
          0.336492891; 3600,0.336492891; 7200,0.336492891; 10800,0.336492891;
          14400,0.336492891; 18000,0.336492891; 21600,0.336492891; 25200,
          0.336492891; 28800,0.168686149; 28860,0.168686149; 28920,0.168686149;
          28980,0.168686149; 29040,0.168686149; 29100,0.168686149; 29160,
          0.168686149; 29220,0.168686149; 30600,0.254395407; 30660,0.254395407;
          30720,0.254395407; 30780,0.254395407; 30840,0.254395407; 30900,
          0.254395407; 30960,0.254395407; 31020,0.254395407; 32400,0.254395407;
          36000,0.254395407; 36060,0.237441393; 36120,0.237441393; 36180,
          0.237441393; 36240,0.237441393; 36300,0.237441393; 36360,0.237441393;
          36420,0.237441393; 37800,0.254395407; 39600,0.254395407; 43200,
          0.254395407; 43260,0.168686149; 43320,0.168686149; 43380,0.168686149;
          43440,0.168686149; 43500,0.168686149; 43560,0.168686149; 43620,
          0.168686149; 45000,0.336492891; 48600,0.562612128; 48660,0.562612128;
          48720,0.562612128; 48780,0.562612128; 48840,0.562612128; 48900,
          0.562612128; 48960,0.562612128; 49020,0.562612128; 50400,0.562612128;
          54000,0.562612128; 54060,0.525117214; 54120,0.525117214; 54180,
          0.525117214; 54240,0.525117214; 54300,0.525117214; 54360,0.525117214;
          54420,0.525117214; 55800,0.562612128; 57600,0.562612128; 61200,
          0.562612128; 64800,0.562612128; 64860,0.168686149; 64920,0.168686149;
          64980,0.168686149; 65040,0.168686149; 65100,0.168686149; 65160,
          0.168686149; 65220,0.168686149; 66600,0.336492891; 68400,0.336492891;
          72000,0.336492891; 75600,0.336492891; 79200,0.336492891; 82800,
          0.336492891])
      annotation (Placement(transformation(extent={{-84,-24},{-68,-8}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_huanchong_wujun(
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,
          0.341232227; 3600,0.341232227; 7200,0.341232227; 10800,0.341232227;
          14400,0.341232227; 18000,0.341232227; 21600,0.341232227; 25200,
          0.341232227; 28800,0.17106201; 28860,0.17106201; 28920,0.17106201;
          28980,0.17106201; 29040,0.17106201; 29100,0.17106201; 29160,0.17106201;
          29220,0.17106201; 30600,0.562612128; 30660,0.562612128; 30720,
          0.562612128; 30780,0.562612128; 30840,0.562612128; 30900,0.562612128;
          30960,0.562612128; 31020,0.562612128; 32400,0.562612128; 36000,
          0.562612128; 36060,0.525117214; 36120,0.525117214; 36180,0.525117214;
          36240,0.525117214; 36300,0.525117214; 36360,0.525117214; 36420,
          0.525117214; 37800,0.562612128; 39600,0.562612128; 43200,0.562612128;
          43260,0.17106201; 43320,0.17106201; 43380,0.17106201; 43440,0.17106201;
          43500,0.17106201; 43560,0.17106201; 43620,0.17106201; 45000,0.341232227;
          48600,0.341232227; 48660,0.341232227; 48720,0.254395407; 48780,
          0.254395407; 48840,0.254395407; 48900,0.254395407; 48960,0.254395407;
          49020,0.254395407; 50400,0.254395407; 54000,0.254395407; 54060,
          0.254395407; 54120,0.237441393; 54180,0.237441393; 54240,0.237441393;
          54300,0.237441393; 54360,0.237441393; 54420,0.237441393; 55800,
          0.254395407; 57600,0.254395407; 61200,0.254395407; 64800,0.254395407;
          64860,0.17106201; 64920,0.17106201; 64980,0.17106201; 65040,0.17106201;
          65100,0.17106201; 65160,0.17106201; 65220,0.17106201; 66600,0.341232227;
          68400,0.341232227; 72000,0.341232227; 75600,0.341232227; 79200,
          0.341232227; 82800,0.341232227])
      annotation (Placement(transformation(extent={{20,-20},{36,-4}})));
  equation

  public
    Buildings.Fluid.FixedResistances.PressureDrop res8(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=435,
      m_flow_nominal=0.195)
                      annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={-44,8})));
  equation
    C_h= C1*res4.m_flow+C2*res6.m_flow+C3*res8.m_flow "PM concentration of the return air";
    Q_h=res4.m_flow+res8.m_flow+res6.m_flow "Return air mass flow";

    if res2.m_flow< 0.00001 then
      C_s =0;
    else
      C_s= (C_x*res1.m_flow+C_h*Q_h)*(1-eta_z)/res2.m_flow;
    end if;

    GasRoom.V*der(C1)= (G_s_1-D)+(res3.m_flow*C_s*(1-eta_hp)+C3*ori.m_flow+ori5.m_flow*C2-C1*res0.m_flow-res4.m_flow*C1)/1.2*3600;
    GasRoom1.V*der(C2)= (G_s_2-D)+(res5.m_flow*C_s*(1-eta_hp)-ori5.m_flow*C2-ori1.m_flow*C2-C2*res01.m_flow-res6.m_flow*C2)/1.2*3600;
    GasRoom2.V*der(C3)= (G_s_3-D)+(res7.m_flow*C_s*(1-eta_hp)+ ori1.m_flow*C2-ori.m_flow*C3-C3*res02.m_flow-res8.m_flow*C3)/1.2*3600;

    connect(sinAir1.ports[1], res1.port_a)
      annotation (Line(points={{-84,70},{-84,72},{-72,72}},
                                                     color={0,127,255},
        thickness=1));
    connect(damExp.port_b, GasRoom.ports[1]) annotation (Line(points={{-10,-20},{
            -10,-24.5},{4,-24.5}},          color={0,127,255}));
    connect(GasRoom.ports[2], damExp1.port_a) annotation (Line(points={{4,-25.5},
            {-8,-25.5},{-8,-40}}, color={0,127,255}));
    connect(GasRoom.ports[3], res0.port_a) annotation (Line(points={{4,-26.5},{
            -2,-26.5},{-2,-46},{2,-46}},                   color={0,127,255}));
    connect(res0.port_b, sinAir2.ports[1]) annotation (Line(points={{12,-46},{
            34.6667,-46},{34.6667,-100}},   color={0,127,255}));
    connect(res1.port_b, res2.port_a)
      annotation (Line(points={{-60,72},{-52,72}}, color={0,127,255}));
    connect(fan11.port_a, res2.port_b)
      annotation (Line(points={{-36,72},{-38,72},{-38,72},{-40,72}},
                                                   color={0,127,255}));
    connect(damExp2.port_b, GasRoom1.ports[1]) annotation (Line(points={{52,-20},
            {52,-28.5},{60,-28.5}},       color={0,127,255}));
    connect(GasRoom1.ports[2], damExp3.port_a) annotation (Line(points={{60,
            -29.5},{50,-29.5},{50,-48}},
                                color={0,127,255}));
    connect(GasRoom1.ports[3], res01.port_a) annotation (Line(points={{60,-30.5},
            {60,-46},{62,-46}},                             color={0,127,255}));
    connect(res01.port_b, sinAir2.ports[2]) annotation (Line(points={{72,-46},{78,
            -46},{78,-70},{36,-70},{36,-100}},    color={0,127,255}));
    connect(fan11.port_b, res3.port_a) annotation (Line(points={{-20,72},{-8,72},{-8,70}},
                           color={0,127,255}));
    connect(res3.port_b, damExp.port_a)
      annotation (Line(points={{-8,58},{-8,-8},{-10,-8}},
                                                    color={0,127,255}));
    connect(damExp1.port_b, res4.port_a) annotation (Line(points={{-8,-52},{-8,
            -56},{-38,-56}},     color={0,127,255}));
    connect(res4.port_b, res1.port_b) annotation (Line(points={{-50,-56},{-56,-56},{-56,72},
            {-60,72}},               color={0,127,255}));
    connect(fan11.port_b, res5.port_a) annotation (Line(points={{-20,72},{12,72},{12,70}},
                           color={0,127,255}));
    connect(res5.port_b, damExp2.port_a) annotation (Line(points={{12,58},{12,0},
            {52,0},{52,-8}},     color={0,127,255}));
    connect(damExp3.port_b, res6.port_a) annotation (Line(points={{50,-60},{50,
            -68},{-38,-68}}, color={0,127,255}));
    connect(res6.port_b, res2.port_a) annotation (Line(points={{-50,-68},{-56,-68},{-56,72},
            {-52,72}},               color={0,127,255}));
    connect(fan11.port_b, res7.port_a) annotation (Line(points={{-20,72},{28,72},{28,70}},
                                                 color={0,127,255}));
    connect(res7.port_b, damExp4.port_a) annotation (Line(points={{28,58},{28,52}},
                                                         color={0,127,255}));
    connect(damExp4.port_b, GasRoom2.ports[1]) annotation (Line(points={{28,40},
            {28,37.5},{48,37.5}},                                    color={0,
            127,255}));
    connect(GasRoom2.ports[2], res02.port_a) annotation (Line(points={{48,36.5},
            {48,32},{42,32},{42,18},{66,18}},        color={0,127,255}));
    connect(sinAir2.ports[3], res02.port_b) annotation (Line(points={{37.3333,
            -100},{42,-100},{42,-72},{86,-72},{86,18},{76,18}}, color={0,127,
            255}));
    connect(GasRoom2.ports[3], damExp5.port_a) annotation (Line(points={{48,35.5},
            {28,35.5},{28,28}},                                    color={0,127,
            255}));
    connect(res8.port_a, damExp5.port_b) annotation (Line(points={{-38,8},{28,8},
            {28,16}},                       color={0,127,255}));
    connect(res8.port_b, res1.port_b) annotation (Line(points={{-50,8},{-56,8},{-56,72},{-60,
            72}},               color={0,127,255}));
    connect(GasRoom2.ports[4], ori.port_a) annotation (Line(points={{48,34.5},{
            0,34.5},{0,10}}, color={0,127,255}));
    connect(ori.port_b, GasRoom.ports[4]) annotation (Line(points={{0,-2},{0,
            -27.5},{4,-27.5}},
                          color={0,127,255}));
    connect(GasRoom1.ports[4], ori1.port_a) annotation (Line(points={{60,-31.5},
            {56,-31.5},{56,-2}},
                             color={0,127,255}));
    connect(ori1.port_b, GasRoom2.ports[5]) annotation (Line(points={{56,10},{
            56,14},{46,14},{46,33.5},{48,33.5}},
                                          color={0,127,255}));
    connect(GasRoom1.ports[5], ori5.port_a) annotation (Line(points={{60,-32.5},
            {48,-32.5},{48,-42},{34,-42}},
                                      color={0,127,255}));
    connect(ori5.port_b, GasRoom.ports[5]) annotation (Line(points={{22,-42},{2,
            -42},{2,-32},{4,-32},{4,-28.5}},       color={0,127,255}));
    connect(realExpression.y, realValue.numberPort)
      annotation (Line(points={{-49,44},{-31.5,44}}, color={0,0,127}));
    connect(realExpression1.y, realValue2.numberPort)
      annotation (Line(points={{-49,-2},{-31.5,-2}}, color={0,0,127}));
    connect(realExpression2.y, realValue3.numberPort)
      annotation (Line(points={{91,-14},{81.5,-14}}, color={0,0,127}));
    connect(senRelPre.port_b, GasRoom.ports[6]) annotation (Line(points={{6,-76},
            {-2,-76},{-2,-29.5},{4,-29.5}},
                                     color={0,127,255}));
    connect(GasRoom1.ports[6], senRelPre.port_a) annotation (Line(points={{60,
            -33.5},{32,-33.5},{32,-76},{26,-76}},
                                          color={0,127,255}));
    connect(senRelPre1.port_b, GasRoom.ports[7]) annotation (Line(points={{-46,-24},
            {-46,-30.5},{4,-30.5}},
                           color={0,127,255}));
    connect(senRelPre1.port_a, GasRoom2.ports[6]) annotation (Line(points={{-46,-4},
            {-46,-4},{-46,16},{-46,16},{-46,32.5},{48,32.5}},
                                                           color={0,127,255}));
    connect(GasRoom1.ports[7], senRelPre2.port_a) annotation (Line(points={{60,
            -34.5},{42,-34.5},{42,-4},{98,-4},{98,2}},
                                               color={0,127,255}));
    connect(senRelPre2.port_b, GasRoom2.ports[7]) annotation (Line(points={{98,22},
            {98,48},{36,48},{36,31.5},{48,31.5}},
                                               color={0,127,255}));
    connect(GasRoom.ports[8], senRelPre3.port_a) annotation (Line(points={{4,
            -31.5},{-82,-31.5},{-82,-60}}, color={0,127,255}));
    connect(senRelPre3.port_b, sinAir2.ports[4])
      annotation (Line(points={{-82,-80},{-22,-80},{-22,-100},{38.6667,-100}},
                                                         color={0,127,255}));
    connect(conPID.u_s, realExpression3.y)
      annotation (Line(points={{-71.2,-46},{-81,-46}}, color={0,0,127}));
    connect(senRelPre3.p_rel, conPID.u_m) annotation (Line(points={{-73,-70},{
            -64,-70},{-64,-53.2}}, color={0,0,127}));
    connect(sinAir2.ports[5], senRelPre4.port_b)
      annotation (Line(points={{40,-100},{46,-100},{46,-80},{50,-80}},
                                                   color={0,127,255}));
    connect(senRelPre4.port_a, GasRoom1.ports[8]) annotation (Line(points={{70,
            -80},{70,-60},{56,-60},{56,-35.5},{60,-35.5}}, color={0,127,255}));
    connect(GasRoom2.ports[8], senRelPre5.port_a) annotation (Line(points={{48,
            30.5},{-94,30.5},{-94,14}}, color={0,127,255}));
    connect(senRelPre5.port_b, sinAir2.ports[6]) annotation (Line(points={{-94,-6},
            {-94,-100},{41.3333,-100}},   color={0,127,255}));
    connect(realExpression6.y, add.u1) annotation (Line(points={{-81,-34},{-54,
            -34},{-54,-42.4},{-49.2,-42.4}}, color={0,0,127}));
    connect(conPID.y, add.u2) annotation (Line(points={{-57.4,-46},{-54,-46},{
            -54,-49.6},{-49.2,-49.6}}, color={0,0,127}));
    connect(add.y, limiter.u)
      annotation (Line(points={{-35.4,-46},{-28.8,-46}}, color={0,0,127}));
    connect(limiter.y, damExp1.y)
      annotation (Line(points={{-19.6,-46},{-15.2,-46}}, color={0,0,127}));
    connect(realExpression4.y, conPID1.u_s)
      annotation (Line(points={{131,-56},{115.2,-56}}, color={0,0,127}));
    connect(senRelPre4.p_rel, conPID1.u_m) annotation (Line(points={{60,-89},{
            60,-92},{108,-92},{108,-63.2}}, color={0,0,127}));
    connect(damExp3.y, limiter1.y)
      annotation (Line(points={{57.2,-54},{61.6,-54}}, color={0,0,127}));
    connect(limiter1.u, add1.y)
      annotation (Line(points={{70.8,-54},{77.4,-54}}, color={0,0,127}));
    connect(conPID1.y, add1.u2) annotation (Line(points={{101.4,-56},{91.2,-56},
            {91.2,-57.6}}, color={0,0,127}));
    connect(realExpression7.y, add1.u1) annotation (Line(points={{105,-38},{98,
            -38},{98,-50.4},{91.2,-50.4}}, color={0,0,127}));
    connect(realExpression5.y, conPID3.u_s)
      annotation (Line(points={{-79,22},{-71.2,22}}, color={0,0,127}));
    connect(senRelPre5.p_rel, conPID3.u_m)
      annotation (Line(points={{-85,4},{-64,4},{-64,14.8}}, color={0,0,127}));
    connect(conPID3.y, add2.u2) annotation (Line(points={{-57.4,22},{-52,22},{
            -52,18.4},{-47.2,18.4}}, color={0,0,127}));
    connect(add2.y, limiter2.u)
      annotation (Line(points={{-33.4,22},{-16.8,22}}, color={0,0,127}));
    connect(damExp5.y, limiter2.y)
      annotation (Line(points={{20.8,22},{-7.6,22}}, color={0,0,127}));
    connect(realExpression8.y, add2.u1) annotation (Line(points={{-67,34},{-54,
            34},{-54,25.6},{-47.2,25.6}}, color={0,0,127}));
    connect(combiTimeTable_huanchong.y[1], damExp4.y) annotation (Line(points={{73.2,86},
            {54,86},{54,46},{35.2,46}},          color={0,0,127}));
    connect(combiTimeTable_huanchong_weisheng.y[1], damExp.y) annotation (Line(
          points={{-67.2,-16},{-42,-16},{-42,-14},{-17.2,-14}}, color={0,0,127}));
    connect(combiTimeTable_huanchong_wujun.y[1], damExp2.y) annotation (Line(
          points={{36.8,-12},{40,-12},{40,-14},{44.8,-14}}, color={0,0,127}));
    connect(combiTimeTable.y[1], fan11.m_flow_in) annotation (Line(points={{-59,96},
            {-28,96},{-28,81.6}},                                color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
              -100},{160,120}})),                                  Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{160,
              120}}),                                  graphics={
          Rectangle(
            extent={{-34,4},{28,-64}},
            lineColor={175,175,175},
            lineThickness=1),
          Rectangle(
            extent={{28,4},{88,-64}},
            lineColor={175,175,175},
            lineThickness=1),
          Rectangle(
            extent={{-34,54},{88,4}},
            lineColor={175,175,175},
            lineThickness=1),
          Rectangle(
            extent={{-106,-24},{-14,-58}},
            lineColor={0,127,255},
            lineThickness=1)}),
      Documentation(info="<html>
<p>Pressure and airflow control.</p>
<p style=\"margin-left: 60px;\">The Pressure of each room was controled by the return damper using the PID controllor. </p>
<p style=\"margin-left: 60px;\">The opening rate of the demper was adjust by considering both the difference of supply and return air and the pressure of the room.</p>
<p style=\"margin-left: 60px;\">The time cost of actuators for damper open was set.</p>
</html>"));
  end newfbs;

  model fenbushi_0511
     package Medium = Buildings.Media.Air;
     parameter Real G_p=654603*60 "PM generation rate for each person";
     parameter Real C_x=10^9 "PM concentration of the fresh air";
     parameter Real eta_z=0.95 "total filter efficiency";
     parameter Real eta_hp=0.9997 "filter efficiency of the inlet air";

    // parameter Real Q_h=res4.m_flow+res8.m_flow+res6.m_flow "Return air mass flow";
     parameter Real D=0 "PM dropt rate";

     Real C1 "PM concteration of the bio test room";
     Real C2 "PM concteration of the no-germ room";
     Real C3 "PM concteration of the huanchong room";
     Real C_s "pm of supply air";
     Real C_h "PM concentration of the return air";
     Real Q_h "Return air mass flow";
     Real G_s_1= G_p*combiTimeTable.y[2] "pm diffusion source per min";
     Real G_s_2= G_p*combiTimeTable.y[3] "pm diffusion source per min";
     Real G_s_3= G_p*combiTimeTable.y[4] "pm diffusion source per min";

    Buildings.Fluid.Sources.Boundary_pT sinAir1(
      nPorts=1,
      redeclare package Medium = Medium,
      p(displayUnit="bar") = 100000,
      T=293.15) "Sink for water circuit"
      annotation (Placement(transformation(extent={{-104,60},{-84,80}})));
    Buildings.Fluid.Movers.FlowControlled_m_flow fan11(
      redeclare package Medium = Medium,
      dp_nominal=1900,
      m_flow_nominal=0.614833333,
      addPowerToMedium=false)                     annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={-28,72})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=100,
      m_flow_nominal=0.369868)
                         annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={-10,-14})));
    Buildings.Fluid.MixingVolumes.MixingVolume GasRoom(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      m_flow_nominal=10,
      nPorts=8,
      T_start=273.15 + 20,
      V=17.82,
      redeclare package Medium = Medium,
      p_start(displayUnit="bar"))
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={14,-28})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp1(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=100,
      m_flow_nominal=0.367868)
                         annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={-8,-46})));
    Buildings.Fluid.Sources.Boundary_pT sinAir2(
      redeclare package Medium = Medium,
      nPorts=6,
      p(displayUnit="bar") = 100000,
      T=293.15) "Sink for water circuit"
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=-90,
          origin={38,-110})));
    Buildings.Fluid.FixedResistances.PressureDrop res1(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=500,
      m_flow_nominal=0.06)
      annotation (Placement(transformation(extent={{-72,66},{-60,78}})));
    Buildings.Fluid.FixedResistances.PressureDrop res0(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=30,
      m_flow_nominal=0.0136)
      annotation (Placement(transformation(extent={{2,-52},{12,-40}})));
    Buildings.Fluid.FixedResistances.PressureDrop res2(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=900,
      m_flow_nominal=0.77)
      annotation (Placement(transformation(extent={{-52,66},{-40,78}})));
    Buildings.Fluid.MixingVolumes.MixingVolume GasRoom1(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      m_flow_nominal=10,
      nPorts=8,
      T_start=273.15 + 20,
      redeclare package Medium = Medium,
      p_start(displayUnit="bar"),
      V=18.6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={70,-32})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp2(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=3,
      m_flow_nominal=0.367306)
                         annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={52,-14})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp3(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=3,
      m_flow_nominal=0.341306)
                         annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=90,
          origin={50,-54})));
    Buildings.Fluid.FixedResistances.PressureDrop res01(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=40,
      m_flow_nominal=0.0142)
      annotation (Placement(transformation(extent={{62,-52},{72,-40}})));
    Buildings.Fluid.FixedResistances.PressureDrop res3(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=370,
      m_flow_nominal=0.237)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={-8,64})));
    Buildings.Fluid.FixedResistances.PressureDrop res4(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=430,
      m_flow_nominal=0.235)
                           annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={-44,-56})));
    Buildings.Fluid.FixedResistances.PressureDrop res5(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=360,
      m_flow_nominal=0.24)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={12,64})));
    Buildings.Fluid.FixedResistances.PressureDrop res6(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=440,
      m_flow_nominal=0.214)
                           annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={-44,-68})));
    Buildings.Fluid.MixingVolumes.MixingVolume GasRoom2(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      m_flow_nominal=10,
      nPorts=8,
      T_start=273.15 + 20,
      redeclare package Medium = Medium,
      p_start(displayUnit="bar"),
      V=21.1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={58,34})));
    Buildings.Fluid.FixedResistances.PressureDrop res7(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=365,
      m_flow_nominal=0.293)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={28,64})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp4(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=180,
      m_flow_nominal=0.399048)
                         annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=90,
          origin={28,46})));
    Buildings.Fluid.FixedResistances.PressureDrop res02(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=35,
      m_flow_nominal=0.032)
      annotation (Placement(transformation(extent={{66,12},{76,24}})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp5(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=180,
      m_flow_nominal=0.367048)
                         annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={28,22})));
    Buildings.Airflow.Multizone.Orifice ori(redeclare package Medium = Medium, A=0.004222)
      annotation (Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={0,4})));
    Buildings.Airflow.Multizone.Orifice ori1(redeclare package Medium = Medium, A=
          0.004222)
               annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=-90,
          origin={56,4})));
    Buildings.Airflow.Multizone.Orifice ori5(redeclare package Medium = Medium, A=
          0.00078)
               annotation (Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=180,
          origin={28,-42})));

    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,
          0.231,0,0,0; 3600,0.231,0,0,0; 7200,0.231,0,0,0; 10800,0.231,0,0,0;
          14400,0.231,0,0,0; 18000,0.231,0,0,0; 21600,0.231,0,0,0; 25200,0.231,0,
          0,0; 28800,0.4209,0,0,0; 28860,0.4209,0,0,1.5; 28920,0.4209,0,0,3;
          28980,0.4209,0,0,2.5; 29040,0.4209,0,0,2.2; 29100,0.4209,0,0,1.8; 29160,
          0.4209,0,0,1.7; 29220,0.4209,0,0,1.65; 30600,0.424933333,0,0,0; 30660,
          0.424933333,0.5,1,0; 30720,0.424933333,1,2,0; 30780,0.424933333,
          0.833333333,1.666666667,0; 30840,0.424933333,0.733333333,1.466666667,0;
          30900,0.424933333,0.6,1.2,0; 30960,0.424933333,0.566666667,1.133333333,
          0; 31020,0.424933333,0.55,1.1,0; 32400,0.424933333,0.55,1.1,0; 36000,
          0.4648,0.55,1.1,0; 36060,0.4648,0.55,1.1,0.5; 36120,0.4648,0.55,1.1,1;
          36180,0.4648,0.55,1.1,0.833333333; 36240,0.4648,0.55,1.1,0.733333333;
          36300,0.4648,0.55,1.1,0.6; 36360,0.4648,0.55,1.1,0.566666667; 36420,
          0.4648,0.55,1.1,0.55; 37800,0.424933333,0.55,1.1,0; 39600,0.424933333,
          0.55,1.1,0; 43200,0.614833333,0,0,0; 43260,0.4209,0,0,1.5; 43320,0.4209,
          0,0,3; 43380,0.4209,0,0,2.5; 43440,0.4209,0,0,2.2; 43500,0.4209,0,0,1.8;
          43560,0.4209,0,0,1.7; 43620,0.4209,0,0,1.65; 45000,0.231,0,0,0; 48600,
          0.424933333,0.6,0.5,0; 48660,0.424933333,1.7,1,0; 48720,0.424933333,
          1.666666667,0.833333333,0; 48780,0.424933333,1.466666667,0.733333333,0;
          48840,0.424933333,1.2,0.6,0; 48900,0.424933333,1.133333333,0.566666667,
          0; 48960,0.424933333,1.1,0.55,0; 49020,0.424933333,1.1,0.55,0; 50400,
          0.424933333,1.1,0.55,0; 54000,0.4648,1.1,0.55,0; 54060,0.4648,1.1,0.55,
          0.5; 54120,0.4648,1.1,0.55,0.8; 54180,0.4648,1.1,0.55,0.733333333;
          54240,0.4648,1.1,0.55,0.733333333; 54300,0.4648,1.1,0.55,0.6; 54360,
          0.4648,1.1,0.55,0.566666667; 54420,0.4648,1.1,0.55,0.55; 55800,
          0.424933333,1.1,0.55,0; 57600,0.424933333,1.1,0.55,0; 61200,0.424933333,
          1.1,0.55,0; 64800,0.614833333,0,0,0; 64860,0.4209,0,0,1.5; 64920,0.4209,
          0,0,3; 64980,0.4209,0,0,2.5; 65040,0.4209,0,0,2.2; 65100,0.4209,0,0,1.8;
          65160,0.4209,0,0,1.7; 65220,0.4209,0,0,1.65; 66600,0.231,0,0,0; 68400,
          0.231,0,0,0; 72000,0.231,0,0,0; 75600,0.231,0,0,0; 79200,0.231,0,0,0;
          82800,0.231,0,0,0])
      annotation (Placement(transformation(extent={{-98,88},{-78,108}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue
      annotation (Placement(transformation(extent={{-30,34},{-10,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=C3)
      annotation (Placement(transformation(extent={{-70,34},{-50,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=C1)
      annotation (Placement(transformation(extent={{-70,-12},{-50,8}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue2
      annotation (Placement(transformation(extent={{-30,-12},{-10,8}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=C2)
      annotation (Placement(transformation(extent={{112,-24},{92,-4}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue3
      annotation (Placement(transformation(extent={{80,-24},{60,-4}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{26,-86},{6,-66}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre1(redeclare package
        Medium =                                                                   Medium)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-46,-14})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre2(redeclare package
        Medium =                                                                   Medium)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={98,12})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre3(redeclare package
        Medium =                                                                   Medium)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-82,-70})));
    Buildings.Controls.Continuous.LimPID conPID(
      reverseAction=true,
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      Td=1,
      yMax=0.2,
      yMin=-0.2,
      Ti=15,
      k=0.01)
      annotation (Placement(transformation(extent={{-70,-52},{-58,-40}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=30)
      annotation (Placement(transformation(extent={{-102,-56},{-82,-36}})));
    Modelica.Blocks.Sources.RealExpression realExpression4(y=40)
      annotation (Placement(transformation(extent={{152,-66},{132,-46}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre4(
                                                       redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{70,-90},{50,-70}})));
    Modelica.Blocks.Sources.RealExpression realExpression5(y=35)
      annotation (Placement(transformation(extent={{-100,12},{-80,32}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre5(
                                                       redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-94,4})));
    Modelica.Blocks.Math.Add add
      annotation (Placement(transformation(extent={{-48,-52},{-36,-40}})));
    Modelica.Blocks.Sources.RealExpression realExpression6(y=ceil((-0.6518*((
          damExp.m_flow - 0.002)/damExp1.m_flow_nominal)*((damExp.m_flow -
          0.002)/damExp1.m_flow_nominal) + 1.5934*((damExp.m_flow - 0.002)/
          damExp1.m_flow_nominal))*10)/10)
      annotation (Placement(transformation(extent={{-102,-44},{-82,-24}})));
    Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0)
      annotation (Placement(transformation(extent={{-28,-50},{-20,-42}})));
    Buildings.Controls.Continuous.LimPID conPID1(
      reverseAction=true,
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      Td=1,
      yMax=0.2,
      yMin=-0.2,
      Ti=15,
      k=0.01)
      annotation (Placement(transformation(extent={{114,-62},{102,-50}})));
    Modelica.Blocks.Math.Add add1
      annotation (Placement(transformation(extent={{90,-60},{78,-48}})));
    Modelica.Blocks.Nonlinear.Limiter limiter1(
                                              uMax=1, uMin=0)
      annotation (Placement(transformation(extent={{70,-58},{62,-50}})));
    Modelica.Blocks.Sources.RealExpression realExpression7(y=ceil((-0.6518*((
          damExp2.m_flow - 0.026)/damExp3.m_flow_nominal)*((damExp2.m_flow -
          0.026)/damExp3.m_flow_nominal) + 1.5934*((damExp2.m_flow - 0.026)/
          damExp3.m_flow_nominal))*10)/10)
      annotation (Placement(transformation(extent={{126,-48},{106,-28}})));
    Buildings.Controls.Continuous.LimPID conPID3(
      reverseAction=true,
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      Td=1,
      yMax=0.2,
      yMin=-0.2,
      Ti=15,
      k=0.01)
      annotation (Placement(transformation(extent={{-70,16},{-58,28}})));
    Modelica.Blocks.Math.Add add2
      annotation (Placement(transformation(extent={{-42,14},{-30,26}})));
    Modelica.Blocks.Nonlinear.Limiter limiter2(
                                              uMax=1, uMin=0)
      annotation (Placement(transformation(extent={{-16,18},{-8,26}})));
    Modelica.Blocks.Sources.RealExpression realExpression8(y=ceil((-0.6518*((
          damExp4.m_flow - 0.032)/damExp5.m_flow_nominal)*((damExp4.m_flow -
          0.032)/damExp5.m_flow_nominal) + 1.5934*((damExp4.m_flow - 0.032)/
          damExp5.m_flow_nominal))*10)/10)
      annotation (Placement(transformation(extent={{-88,24},{-68,44}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_huanchong(smoothness=
          Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,0.3; 3600,
          0.3; 7200,0.3; 10800,0.3; 14400,0.3; 18000,0.3; 21600,0.3; 25200,0.3;
          28800,0.947386364; 28860,0.947386364; 28920,0.947386364; 28980,
          0.947386364; 29040,0.947386364; 29100,0.947386364; 29160,0.947386364;
          29220,0.947386364; 30600,0.3; 30660,0.3; 30720,0.3; 30780,0.3; 30840,
          0.3; 30900,0.3; 30960,0.3; 31020,0.3; 32400,0.3; 36000,0.435909091;
          36060,0.435909091; 36120,0.435909091; 36180,0.435909091; 36240,
          0.435909091; 36300,0.435909091; 36360,0.435909091; 36420,0.435909091;
          37800,0.3; 39600,0.3; 43200,0.947386364; 43260,0.947386364; 43320,
          0.947386364; 43380,0.947386364; 43440,0.947386364; 43500,0.947386364;
          43560,0.947386364; 43620,0.947386364; 45000,0.3; 48600,0.3; 48660,0.3;
          48720,0.3; 48780,0.3; 48840,0.3; 48900,0.3; 48960,0.3; 49020,0.3; 50400,
          0.3; 54000,0.435909091; 54060,0.435909091; 54120,0.435909091; 54180,
          0.435909091; 54240,0.435909091; 54300,0.435909091; 54360,0.435909091;
          54420,0.435909091; 55800,0.3; 57600,0.3; 61200,0.3; 64800,0.947386364;
          64860,0.947386364; 64920,0.947386364; 64980,0.947386364; 65040,
          0.947386364; 65100,0.947386364; 65160,0.947386364; 65220,0.947386364;
          66600,0.3; 68400,0.3; 72000,0.3; 75600,0.3; 79200,0.3; 82800,0.3])
      annotation (Placement(transformation(extent={{90,78},{74,94}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_huanchong_weisheng(
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,
          0.3; 3600,0.3; 7200,0.3; 10800,0.3; 14400,0.3; 18000,0.3; 21600,0.3;
          25200,0.3; 28800,0.3; 28860,0.3; 28920,0.3; 28980,0.3; 29040,0.3; 29100,
          0.3; 29160,0.3; 29220,0.3; 30600,0.54028169; 30660,0.54028169; 30720,
          0.54028169; 30780,0.54028169; 30840,0.54028169; 30900,0.54028169; 30960,
          0.54028169; 31020,0.54028169; 32400,0.54028169; 36000,0.54028169; 36060,
          0.54028169; 36120,0.54028169; 36180,0.54028169; 36240,0.54028169; 36300,
          0.54028169; 36360,0.54028169; 36420,0.54028169; 37800,0.54028169; 39600,
          0.54028169; 43200,0.54028169; 43260,0.3; 43320,0.3; 43380,0.3; 43440,
          0.3; 43500,0.3; 43560,0.3; 43620,0.3; 45000,0.3; 48600,0.883380282;
          48660,0.883380282; 48720,0.883380282; 48780,0.883380282; 48840,
          0.883380282; 48900,0.883380282; 48960,0.883380282; 49020,0.883380282;
          50400,0.883380282; 54000,0.883380282; 54060,0.883380282; 54120,
          0.883380282; 54180,0.883380282; 54240,0.883380282; 54300,0.883380282;
          54360,0.883380282; 54420,0.883380282; 55800,0.883380282; 57600,
          0.883380282; 61200,0.883380282; 64800,0.883380282; 64860,0.3; 64920,0.3;
          64980,0.3; 65040,0.3; 65100,0.3; 65160,0.3; 65220,0.3; 66600,0.3; 68400,
          0.3; 72000,0.3; 75600,0.3; 79200,0.3; 82800,0.3])
      annotation (Placement(transformation(extent={{-84,-24},{-68,-8}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_huanchong_wujun(
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,
          0.3; 3600,0.3; 7200,0.3; 10800,0.3; 14400,0.3; 18000,0.3; 21600,0.3;
          25200,0.3; 28800,0.3; 28860,0.3; 28920,0.3; 28980,0.3; 29040,0.3; 29100,
          0.3; 29160,0.3; 29220,0.3; 30600,0.871111111; 30660,0.871111111; 30720,
          0.871111111; 30780,0.871111111; 30840,0.871111111; 30900,0.871111111;
          30960,0.871111111; 31020,0.871111111; 32400,0.871111111; 36000,
          0.871111111; 36060,0.871111111; 36120,0.871111111; 36180,0.871111111;
          36240,0.871111111; 36300,0.871111111; 36360,0.871111111; 36420,
          0.871111111; 37800,0.871111111; 39600,0.871111111; 43200,0.871111111;
          43260,0.3; 43320,0.3; 43380,0.3; 43440,0.3; 43500,0.3; 43560,0.3; 43620,
          0.3; 45000,0.3; 48600,0.532777778; 48660,0.532777778; 48720,0.532777778;
          48780,0.532777778; 48840,0.532777778; 48900,0.532777778; 48960,
          0.532777778; 49020,0.532777778; 50400,0.532777778; 54000,0.532777778;
          54060,0.532777778; 54120,0.532777778; 54180,0.532777778; 54240,
          0.532777778; 54300,0.532777778; 54360,0.532777778; 54420,0.532777778;
          55800,0.532777778; 57600,0.532777778; 61200,0.532777778; 64800,
          0.532777778; 64860,0.3; 64920,0.3; 64980,0.3; 65040,0.3; 65100,0.3;
          65160,0.3; 65220,0.3; 66600,0.3; 68400,0.3; 72000,0.3; 75600,0.3; 79200,
          0.3; 82800,0.3])
      annotation (Placement(transformation(extent={{20,-20},{36,-4}})));
  equation

  public
    Buildings.Fluid.FixedResistances.PressureDrop res8(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=435,
      m_flow_nominal=0.261)
                      annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={-44,8})));
  equation
    C_h= C1*res4.m_flow+C2*res6.m_flow+C3*res8.m_flow "PM concentration of the return air";
    Q_h=res4.m_flow+res8.m_flow+res6.m_flow "Return air mass flow";

    if res2.m_flow< 0.00001 then
      C_s =0;
    else
      C_s= (C_x*res1.m_flow+C_h*Q_h)*(1-eta_z)/res2.m_flow;
    end if;

    GasRoom.V*der(C1)= (G_s_1-D)+(res3.m_flow*C_s*(1-eta_hp)+C3*ori.m_flow+ori5.m_flow*C2-C1*res0.m_flow-res4.m_flow*C1)/1.2*3600;
    GasRoom1.V*der(C2)= (G_s_2-D)+(res5.m_flow*C_s*(1-eta_hp)-ori5.m_flow*C2-ori1.m_flow*C2-C2*res01.m_flow-res6.m_flow*C2)/1.2*3600;
    GasRoom2.V*der(C3)= (G_s_3-D)+(res7.m_flow*C_s*(1-eta_hp)+ ori1.m_flow*C2-ori.m_flow*C3-C3*res02.m_flow-res8.m_flow*C3)/1.2*3600;

    connect(sinAir1.ports[1], res1.port_a)
      annotation (Line(points={{-84,70},{-84,72},{-72,72}},
                                                     color={0,127,255},
        thickness=1));
    connect(damExp.port_b, GasRoom.ports[1]) annotation (Line(points={{-10,-20},{
            -10,-24.5},{4,-24.5}},          color={0,127,255}));
    connect(GasRoom.ports[2], damExp1.port_a) annotation (Line(points={{4,-25.5},
            {-8,-25.5},{-8,-40}}, color={0,127,255}));
    connect(GasRoom.ports[3], res0.port_a) annotation (Line(points={{4,-26.5},{
            -2,-26.5},{-2,-46},{2,-46}},                   color={0,127,255}));
    connect(res0.port_b, sinAir2.ports[1]) annotation (Line(points={{12,-46},{
            34.6667,-46},{34.6667,-100}},   color={0,127,255}));
    connect(res1.port_b, res2.port_a)
      annotation (Line(points={{-60,72},{-52,72}}, color={0,127,255}));
    connect(fan11.port_a, res2.port_b)
      annotation (Line(points={{-36,72},{-38,72},{-38,72},{-40,72}},
                                                   color={0,127,255}));
    connect(damExp2.port_b, GasRoom1.ports[1]) annotation (Line(points={{52,-20},
            {52,-28.5},{60,-28.5}},       color={0,127,255}));
    connect(GasRoom1.ports[2], damExp3.port_a) annotation (Line(points={{60,
            -29.5},{50,-29.5},{50,-48}},
                                color={0,127,255}));
    connect(GasRoom1.ports[3], res01.port_a) annotation (Line(points={{60,-30.5},
            {60,-46},{62,-46}},                             color={0,127,255}));
    connect(res01.port_b, sinAir2.ports[2]) annotation (Line(points={{72,-46},{78,
            -46},{78,-70},{36,-70},{36,-100}},    color={0,127,255}));
    connect(fan11.port_b, res3.port_a) annotation (Line(points={{-20,72},{-8,72},{-8,70}},
                           color={0,127,255}));
    connect(res3.port_b, damExp.port_a)
      annotation (Line(points={{-8,58},{-8,-8},{-10,-8}},
                                                    color={0,127,255}));
    connect(damExp1.port_b, res4.port_a) annotation (Line(points={{-8,-52},{-8,
            -56},{-38,-56}},     color={0,127,255}));
    connect(res4.port_b, res1.port_b) annotation (Line(points={{-50,-56},{-56,-56},{-56,72},
            {-60,72}},               color={0,127,255}));
    connect(fan11.port_b, res5.port_a) annotation (Line(points={{-20,72},{12,72},{12,70}},
                           color={0,127,255}));
    connect(res5.port_b, damExp2.port_a) annotation (Line(points={{12,58},{12,0},
            {52,0},{52,-8}},     color={0,127,255}));
    connect(damExp3.port_b, res6.port_a) annotation (Line(points={{50,-60},{50,
            -68},{-38,-68}}, color={0,127,255}));
    connect(res6.port_b, res2.port_a) annotation (Line(points={{-50,-68},{-58,
            -68},{-58,72},{-52,72}}, color={0,127,255}));
    connect(fan11.port_b, res7.port_a) annotation (Line(points={{-20,72},{28,72},{28,70}},
                                                 color={0,127,255}));
    connect(res7.port_b, damExp4.port_a) annotation (Line(points={{28,58},{28,52}},
                                                         color={0,127,255}));
    connect(damExp4.port_b, GasRoom2.ports[1]) annotation (Line(points={{28,40},
            {28,37.5},{48,37.5}},                                    color={0,
            127,255}));
    connect(GasRoom2.ports[2], res02.port_a) annotation (Line(points={{48,36.5},
            {48,32},{42,32},{42,18},{66,18}},        color={0,127,255}));
    connect(sinAir2.ports[3], res02.port_b) annotation (Line(points={{37.3333,
            -100},{42,-100},{42,-72},{86,-72},{86,18},{76,18}}, color={0,127,
            255}));
    connect(GasRoom2.ports[3], damExp5.port_a) annotation (Line(points={{48,35.5},
            {28,35.5},{28,28}},                                    color={0,127,
            255}));
    connect(res8.port_a, damExp5.port_b) annotation (Line(points={{-38,8},{28,8},
            {28,16}},                       color={0,127,255}));
    connect(res8.port_b, res1.port_b) annotation (Line(points={{-50,8},{-54,8},
            {-54,72},{-60,72}}, color={0,127,255}));
    connect(GasRoom2.ports[4], ori.port_a) annotation (Line(points={{48,34.5},{
            0,34.5},{0,10}}, color={0,127,255}));
    connect(ori.port_b, GasRoom.ports[4]) annotation (Line(points={{0,-2},{0,
            -27.5},{4,-27.5}},
                          color={0,127,255}));
    connect(GasRoom1.ports[4], ori1.port_a) annotation (Line(points={{60,-31.5},
            {56,-31.5},{56,-2}},
                             color={0,127,255}));
    connect(ori1.port_b, GasRoom2.ports[5]) annotation (Line(points={{56,10},{
            56,14},{46,14},{46,33.5},{48,33.5}},
                                          color={0,127,255}));
    connect(GasRoom1.ports[5], ori5.port_a) annotation (Line(points={{60,-32.5},
            {48,-32.5},{48,-42},{34,-42}},
                                      color={0,127,255}));
    connect(ori5.port_b, GasRoom.ports[5]) annotation (Line(points={{22,-42},{2,
            -42},{2,-32},{4,-32},{4,-28.5}},       color={0,127,255}));
    connect(realExpression.y, realValue.numberPort)
      annotation (Line(points={{-49,44},{-31.5,44}}, color={0,0,127}));
    connect(realExpression1.y, realValue2.numberPort)
      annotation (Line(points={{-49,-2},{-31.5,-2}}, color={0,0,127}));
    connect(realExpression2.y, realValue3.numberPort)
      annotation (Line(points={{91,-14},{81.5,-14}}, color={0,0,127}));
    connect(senRelPre.port_b, GasRoom.ports[6]) annotation (Line(points={{6,-76},
            {-2,-76},{-2,-29.5},{4,-29.5}},
                                     color={0,127,255}));
    connect(GasRoom1.ports[6], senRelPre.port_a) annotation (Line(points={{60,
            -33.5},{32,-33.5},{32,-76},{26,-76}},
                                          color={0,127,255}));
    connect(senRelPre1.port_b, GasRoom.ports[7]) annotation (Line(points={{-46,-24},
            {-46,-30.5},{4,-30.5}},
                           color={0,127,255}));
    connect(senRelPre1.port_a, GasRoom2.ports[6]) annotation (Line(points={{-46,-4},
            {-46,-4},{-46,16},{-46,16},{-46,32.5},{48,32.5}},
                                                           color={0,127,255}));
    connect(GasRoom1.ports[7], senRelPre2.port_a) annotation (Line(points={{60,
            -34.5},{42,-34.5},{42,-4},{98,-4},{98,2}},
                                               color={0,127,255}));
    connect(senRelPre2.port_b, GasRoom2.ports[7]) annotation (Line(points={{98,22},
            {98,48},{36,48},{36,31.5},{48,31.5}},
                                               color={0,127,255}));
    connect(GasRoom.ports[8], senRelPre3.port_a) annotation (Line(points={{4,
            -31.5},{-82,-31.5},{-82,-60}}, color={0,127,255}));
    connect(senRelPre3.port_b, sinAir2.ports[4])
      annotation (Line(points={{-82,-80},{-22,-80},{-22,-100},{38.6667,-100}},
                                                         color={0,127,255}));
    connect(conPID.u_s, realExpression3.y)
      annotation (Line(points={{-71.2,-46},{-81,-46}}, color={0,0,127}));
    connect(senRelPre3.p_rel, conPID.u_m) annotation (Line(points={{-73,-70},{
            -64,-70},{-64,-53.2}}, color={0,0,127}));
    connect(sinAir2.ports[5], senRelPre4.port_b)
      annotation (Line(points={{40,-100},{46,-100},{46,-80},{50,-80}},
                                                   color={0,127,255}));
    connect(senRelPre4.port_a, GasRoom1.ports[8]) annotation (Line(points={{70,
            -80},{70,-60},{56,-60},{56,-35.5},{60,-35.5}}, color={0,127,255}));
    connect(GasRoom2.ports[8], senRelPre5.port_a) annotation (Line(points={{48,
            30.5},{-94,30.5},{-94,14}}, color={0,127,255}));
    connect(senRelPre5.port_b, sinAir2.ports[6]) annotation (Line(points={{-94,-6},
            {-94,-100},{41.3333,-100}},   color={0,127,255}));
    connect(realExpression6.y, add.u1) annotation (Line(points={{-81,-34},{-54,
            -34},{-54,-42.4},{-49.2,-42.4}}, color={0,0,127}));
    connect(conPID.y, add.u2) annotation (Line(points={{-57.4,-46},{-54,-46},{
            -54,-49.6},{-49.2,-49.6}}, color={0,0,127}));
    connect(add.y, limiter.u)
      annotation (Line(points={{-35.4,-46},{-28.8,-46}}, color={0,0,127}));
    connect(limiter.y, damExp1.y)
      annotation (Line(points={{-19.6,-46},{-15.2,-46}}, color={0,0,127}));
    connect(realExpression4.y, conPID1.u_s)
      annotation (Line(points={{131,-56},{115.2,-56}}, color={0,0,127}));
    connect(senRelPre4.p_rel, conPID1.u_m) annotation (Line(points={{60,-89},{
            60,-92},{108,-92},{108,-63.2}}, color={0,0,127}));
    connect(damExp3.y, limiter1.y)
      annotation (Line(points={{57.2,-54},{61.6,-54}}, color={0,0,127}));
    connect(limiter1.u, add1.y)
      annotation (Line(points={{70.8,-54},{77.4,-54}}, color={0,0,127}));
    connect(conPID1.y, add1.u2) annotation (Line(points={{101.4,-56},{91.2,-56},
            {91.2,-57.6}}, color={0,0,127}));
    connect(realExpression7.y, add1.u1) annotation (Line(points={{105,-38},{98,
            -38},{98,-50.4},{91.2,-50.4}}, color={0,0,127}));
    connect(realExpression5.y, conPID3.u_s)
      annotation (Line(points={{-79,22},{-71.2,22}}, color={0,0,127}));
    connect(senRelPre5.p_rel, conPID3.u_m)
      annotation (Line(points={{-85,4},{-64,4},{-64,14.8}}, color={0,0,127}));
    connect(conPID3.y, add2.u2) annotation (Line(points={{-57.4,22},{-52,22},{
            -52,16.4},{-43.2,16.4}}, color={0,0,127}));
    connect(add2.y, limiter2.u)
      annotation (Line(points={{-29.4,20},{-26,20},{-26,22},{-16.8,22}},
                                                       color={0,0,127}));
    connect(damExp5.y, limiter2.y)
      annotation (Line(points={{20.8,22},{-7.6,22}}, color={0,0,127}));
    connect(realExpression8.y, add2.u1) annotation (Line(points={{-67,34},{-54,
            34},{-54,23.6},{-43.2,23.6}}, color={0,0,127}));
    connect(combiTimeTable_huanchong.y[1], damExp4.y) annotation (Line(points={{73.2,86},
            {54,86},{54,46},{35.2,46}},          color={0,0,127}));
    connect(combiTimeTable_huanchong_weisheng.y[1], damExp.y) annotation (Line(
          points={{-67.2,-16},{-42,-16},{-42,-14},{-17.2,-14}}, color={0,0,127}));
    connect(combiTimeTable_huanchong_wujun.y[1], damExp2.y) annotation (Line(
          points={{36.8,-12},{40,-12},{40,-14},{44.8,-14}}, color={0,0,127}));
    connect(combiTimeTable.y[1], fan11.m_flow_in) annotation (Line(points={{-77,98},
            {-28,98},{-28,81.6}},                                color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,
              -100},{160,120}})),                                  Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{160,
              120}}),                                  graphics={
          Rectangle(
            extent={{-34,4},{28,-64}},
            lineColor={175,175,175},
            lineThickness=1),
          Rectangle(
            extent={{28,4},{88,-64}},
            lineColor={175,175,175},
            lineThickness=1),
          Rectangle(
            extent={{-34,54},{88,4}},
            lineColor={175,175,175},
            lineThickness=1),
          Rectangle(
            extent={{-106,-24},{-14,-58}},
            lineColor={0,127,255},
            lineThickness=1)}),
      Documentation(info="<html>
<p>Pressure and airflow control.</p>
<p style=\"margin-left: 60px;\">The Pressure of each room was controled by the return damper using the PID controllor. </p>
<p style=\"margin-left: 60px;\">The opening rate of the demper was adjust by considering both the difference of supply and return air and the pressure of the room.</p>
<p style=\"margin-left: 60px;\">The time cost of actuators for damper open was set.</p>
</html>"),     Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end fenbushi_0511;

  model fbs_0513
     package Medium = Buildings.Media.Air;
     parameter Real G_p=654603*60 "PM generation rate for each person";
     parameter Real C_x=10^9 "PM concentration of the fresh air";
     parameter Real eta_z=0.95 "total filter efficiency";
     parameter Real eta_hp=0.9997 "filter efficiency of the inlet air";

    // parameter Real Q_h=res4.m_flow+res8.m_flow+res6.m_flow "Return air mass flow";
     parameter Real D=0 "PM dropt rate";

     Real C1 "PM concteration of the bio test room";
     Real C2 "PM concteration of the no-germ room";
     Real C3 "PM concteration of the huanchong room";
     Real C_s "pm of supply air";
     Real C_h "PM concentration of the return air";
     Real Q_h "Return air mass flow";
     Real G_s_1= G_p*combiTimeTable.y[2] "pm diffusion source per min";
     Real G_s_2= G_p*combiTimeTable.y[3] "pm diffusion source per min";
     Real G_s_3= G_p*combiTimeTable.y[4] "pm diffusion source per min";

    Buildings.Fluid.Sources.Boundary_pT sinAir1(
      nPorts=1,
      redeclare package Medium = Medium,
      p(displayUnit="bar") = 100000,
      T=293.15) "Sink for water circuit"
      annotation (Placement(transformation(extent={{-104,60},{-84,80}})));
    Buildings.Fluid.Movers.FlowControlled_m_flow fan11(
      addPowerToMedium=false,
      redeclare package Medium = Medium,
      dp_nominal=1900,
      m_flow_nominal=0.77)                        annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={-28,72})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=100,
      m_flow_nominal=0.237)
                         annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={-10,-14})));
    Buildings.Fluid.MixingVolumes.MixingVolume GasRoom(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      m_flow_nominal=10,
      nPorts=8,
      T_start=273.15 + 20,
      V=17.82,
      redeclare package Medium = Medium,
      p_start(displayUnit="bar"))
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={14,-28})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp1(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      m_flow_nominal=0.235,
      dpDamper_nominal=100,
      riseTime=100)      annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={-8,-46})));
    Buildings.Fluid.Sources.Boundary_pT sinAir2(
      redeclare package Medium = Medium,
      nPorts=6,
      p(displayUnit="bar") = 100000,
      T=293.15) "Sink for water circuit"
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=-90,
          origin={38,-110})));
    Buildings.Fluid.FixedResistances.PressureDrop res1(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=500,
      m_flow_nominal=0.06)
      annotation (Placement(transformation(extent={{-72,66},{-60,78}})));
    Buildings.Fluid.FixedResistances.PressureDrop res0(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=30,
      m_flow_nominal=0.0136)
      annotation (Placement(transformation(extent={{2,-52},{12,-40}})));
    Buildings.Fluid.FixedResistances.PressureDrop res2(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=900,
      m_flow_nominal=0.77)
      annotation (Placement(transformation(extent={{-52,66},{-40,78}})));
    Buildings.Fluid.MixingVolumes.MixingVolume GasRoom1(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      m_flow_nominal=10,
      nPorts=8,
      T_start=273.15 + 20,
      redeclare package Medium = Medium,
      p_start(displayUnit="bar"),
      V=18.6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={70,-32})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp2(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=3,
      m_flow_nominal=0.24)
                         annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=90,
          origin={52,-8})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp3(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      m_flow_nominal=0.214,
      riseTime=3)        annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=90,
          origin={50,-54})));
    Buildings.Fluid.FixedResistances.PressureDrop res01(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=40,
      m_flow_nominal=0.0142)
      annotation (Placement(transformation(extent={{62,-52},{72,-40}})));
    Buildings.Fluid.FixedResistances.PressureDrop res3(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=370,
      m_flow_nominal=0.237)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={-8,64})));
    Buildings.Fluid.FixedResistances.PressureDrop res4(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=430,
      m_flow_nominal=0.235)
                           annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={-44,-56})));
    Buildings.Fluid.FixedResistances.PressureDrop res5(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=360,
      m_flow_nominal=0.24)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={12,64})));
    Buildings.Fluid.FixedResistances.PressureDrop res6(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=440,
      m_flow_nominal=0.214)
                           annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={-44,-68})));
    Buildings.Fluid.MixingVolumes.MixingVolume GasRoom2(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      m_flow_nominal=10,
      nPorts=8,
      T_start=273.15 + 20,
      redeclare package Medium = Medium,
      p_start(displayUnit="bar"),
      V=21.1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={58,34})));
    Buildings.Fluid.FixedResistances.PressureDrop res7(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=365,
      m_flow_nominal=0.293)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={28,64})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp4(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=180,
      m_flow_nominal=0.293)
                         annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=90,
          origin={28,46})));
    Buildings.Fluid.FixedResistances.PressureDrop res02(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=35,
      m_flow_nominal=0.032)
      annotation (Placement(transformation(extent={{66,12},{76,24}})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp5(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=180,
      m_flow_nominal=0.261)
                         annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={28,22})));
    Buildings.Airflow.Multizone.Orifice ori(redeclare package Medium = Medium, A=0.004222)
      annotation (Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={0,4})));
    Buildings.Airflow.Multizone.Orifice ori1(redeclare package Medium = Medium, A=
          0.004222)
               annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=-90,
          origin={56,4})));
    Buildings.Airflow.Multizone.Orifice ori5(redeclare package Medium = Medium, A=
          0.00078)
               annotation (Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=180,
          origin={28,-42})));

    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,
          0.211,0,0,0; 3600,0,0,0,0; 7200,0,0,0,0; 10800,0,0,0,0; 14400,0,0,0,0;
          18000,0,0,0,0; 21600,0,0,0,0; 25200,0,0,0,0; 28800,0,0,0,0; 28860,0,0,
          0,1.5; 28920,0,0,0,3; 28980,0,0,0,2.5; 29040,0,0,0,2.2; 29100,0,0,0,
          1.8; 29160,0,0,0,1.7; 29220,0,0,0,1.65; 30600,0,0,0,0; 30660,0,0.5,1,
          0; 30720,0,1,2,0; 30780,0,0.833333,1.666667,0; 30840,0,0.733333,
          1.466667,0; 30900,0,0.6,1.2,0; 30960,0,0.566667,1.133333,0; 31020,0,
          0.55,1.1,0; 32400,0,0.55,1.1,0; 36000,0,0.55,1.1,0; 36060,0,0.55,1.1,
          0.5; 36120,0,0.55,1.1,1; 36180,0,0.55,1.1,0.833333; 36240,0,0.55,1.1,
          0.733333; 36300,0,0.55,1.1,0.6; 36360,0,0.55,1.1,0.566667; 36420,0,
          0.55,1.1,0.55; 37800,0,0.55,1.1,0; 39600,0,0.55,1.1,0; 43200,0,0,0,0;
          43260,0,0,0,1.5; 43320,0,0,0,3; 43380,0,0,0,2.5; 43440,0,0,0,2.2;
          43500,0,0,0,1.8; 43560,0,0,0,1.7; 43620,0,0,0,1.65; 45000,0,0,0,0;
          48600,0,1,0.5,0; 48660,0,2,1,0; 48720,0,1.666667,0.833333,0; 48780,0,
          1.466667,0.733333,0; 48840,0,1.2,0.6,0; 48900,0,1.133333,0.566667,0;
          48960,0,1.1,0.55,0; 49020,0,1.1,0.55,0; 50400,0,1.1,0.55,0; 54000,0,
          1.1,0.55,0; 54060,0,1.1,0.55,0.5; 54120,0,1.1,0.55,1; 54180,0,1.1,
          0.55,0.833333; 54240,0,1.1,0.55,0.733333; 54300,0,1.1,0.55,0.6; 54360,
          0,1.1,0.55,0.566667; 54420,0,1.1,0.55,0.55; 55800,0,1.1,0.55,0; 57600,
          0,1.1,0.55,0; 61200,0,1.1,0.55,0; 64800,0,0,0,0; 64860,0,0,0,1.5;
          64920,0,0,0,3; 64980,0,0,0,2.5; 65040,0,0,0,2.2; 65100,0,0,0,1.8;
          65160,0,0,0,1.7; 65220,0,0,0,1.65; 66600,0,0,0,0; 68400,0,0,0,0;
          72000,0,0,0,0; 75600,0,0,0,0; 79200,0,0,0,0; 82800,0,0,0,0])
      annotation (Placement(transformation(extent={{-82,98},{-62,118}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue
      annotation (Placement(transformation(extent={{-30,34},{-10,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=C3)
      annotation (Placement(transformation(extent={{-70,34},{-50,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=C1)
      annotation (Placement(transformation(extent={{-70,-12},{-50,8}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue2
      annotation (Placement(transformation(extent={{-30,-12},{-10,8}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=C2)
      annotation (Placement(transformation(extent={{112,-24},{92,-4}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue3
      annotation (Placement(transformation(extent={{80,-24},{60,-4}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{26,-86},{6,-66}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre1(redeclare package Medium = Medium)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-46,-14})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre2(redeclare package Medium = Medium)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={98,12})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre3(redeclare package Medium = Medium)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-82,-78})));
    Buildings.Controls.Continuous.LimPID conPID(
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      Ti=15,
      yMax=1,
      yMin=0,
      reverseAction=false,
      k=50,
      Td=10)
      annotation (Placement(transformation(extent={{-72,-52},{-60,-40}})));
    Modelica.Blocks.Sources.RealExpression realExpression4(y=damExp3.m_flow)
      annotation (Placement(transformation(extent={{142,-82},{122,-62}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre4(
                                                       redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{70,-90},{50,-70}})));
    Modelica.Blocks.Sources.RealExpression realExpression5(y=damExp5.m_flow)
      annotation (Placement(transformation(extent={{-88,8},{-68,28}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre5(
                                                       redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-94,4})));
    Modelica.Blocks.Sources.RealExpression realExpression6(y=damExp.m_flow -
          0.002)
      annotation (Placement(transformation(extent={{-122,-56},{-102,-36}})));
    Modelica.Blocks.Sources.RealExpression realExpression7(y=damExp2.m_flow -
          0.026)
      annotation (Placement(transformation(extent={{144,-64},{124,-44}})));
    Modelica.Blocks.Sources.RealExpression realExpression8(y=damExp4.m_flow -
          0.032)
      annotation (Placement(transformation(extent={{-86,20},{-66,40}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_huanchong(smoothness=
          Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,0.3; 3600,
          0; 7200,0; 10800,0; 14400,0; 18000,0; 21600,0; 25200,0; 28800,0;
          28860,0; 28920,0; 28980,0; 29040,0; 29100,0; 29160,0; 29220,0; 30600,
          0; 30660,0; 30720,0; 30780,0; 30840,0; 30900,0; 30960,0; 31020,0;
          32400,0; 36000,0; 36060,0; 36120,0; 36180,0; 36240,0; 36300,0; 36360,
          0; 36420,0; 37800,0; 39600,0; 43200,0; 43260,0; 43320,0; 43380,0;
          43440,0; 43500,0; 43560,0; 43620,0; 45000,0; 48600,0; 48660,0; 48720,
          0; 48780,0; 48840,0; 48900,0; 48960,0; 49020,0; 50400,0; 54000,0;
          54060,0; 54120,0; 54180,0; 54240,0; 54300,0; 54360,0; 54420,0; 55800,
          0; 57600,0; 61200,0; 64800,0; 64860,0; 64920,0; 64980,0; 65040,0;
          65100,0; 65160,0; 65220,0; 66600,0; 68400,0; 72000,0; 75600,0; 79200,
          0; 82800,0])
      annotation (Placement(transformation(extent={{90,78},{74,94}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_weisheng(smoothness=
          Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,0.3; 3600,
          0; 7200,0; 10800,0; 14400,0; 18000,0; 21600,0; 25200,0; 28800,0;
          28860,0; 28920,0; 28980,0; 29040,0; 29100,0; 29160,0; 29220,0; 30600,
          0; 30660,0; 30720,0; 30780,0; 30840,0; 30900,0; 30960,0; 31020,0;
          32400,0; 36000,0; 36060,0; 36120,0; 36180,0; 36240,0; 36300,0; 36360,
          0; 36420,0; 37800,0; 39600,0; 43200,0; 43260,0; 43320,0; 43380,0;
          43440,0; 43500,0; 43560,0; 43620,0; 45000,0; 48600,0; 48660,0; 48720,
          0; 48780,0; 48840,0; 48900,0; 48960,0; 49020,0; 50400,0; 54000,0;
          54060,0; 54120,0; 54180,0; 54240,0; 54300,0; 54360,0; 54420,0; 55800,
          0; 57600,0; 61200,0; 64800,0; 64860,0; 64920,0; 64980,0; 65040,0;
          65100,0; 65160,0; 65220,0; 66600,0; 68400,0; 72000,0; 75600,0; 79200,
          0; 82800,0])
      annotation (Placement(transformation(extent={{-152,-16},{-136,0}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_wujun(smoothness=
          Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,0.3; 3600,
          0; 7200,0; 10800,0; 14400,0; 18000,0; 21600,0; 25200,0; 28800,0;
          28860,0; 28920,0; 28980,0; 29040,0; 29100,0; 29160,0; 29220,0; 30600,
          0; 30660,0; 30720,0; 30780,0; 30840,0; 30900,0; 30960,0; 31020,0;
          32400,0; 36000,0; 36060,0; 36120,0; 36180,0; 36240,0; 36300,0; 36360,
          0; 36420,0; 37800,0; 39600,0; 43200,0; 43260,0; 43320,0; 43380,0;
          43440,0; 43500,0; 43560,0; 43620,0; 45000,0; 48600,0; 48660,0; 48720,
          0; 48780,0; 48840,0; 48900,0; 48960,0; 49020,0; 50400,0; 54000,0;
          54060,0; 54120,0; 54180,0; 54240,0; 54300,0; 54360,0; 54420,0; 55800,
          0; 57600,0; 61200,0; 64800,0; 64860,0; 64920,0; 64980,0; 65040,0;
          65100,0; 65160,0; 65220,0; 66600,0; 68400,0; 72000,0; 75600,0; 79200,
          0; 82800,0])
      annotation (Placement(transformation(extent={{172,-12},{156,4}})));
    Buildings.Controls.Continuous.LimPID conPID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      Td=1,
      Ti=15,
      yMax=1,
      yMin=0,
      reverseAction=false,
      k=100)
      annotation (Placement(transformation(extent={{62,80},{50,92}})));
    Modelica.Blocks.Sources.RealExpression realExpression9(y=damExp4.m_flow/
          damExp4.m_flow_nominal)
      annotation (Placement(transformation(extent={{86,54},{66,74}})));
    Modelica.Blocks.Sources.RealExpression realExpression10(y=damExp2.m_flow/
          damExp2.m_flow_nominal)
      annotation (Placement(transformation(extent={{158,-36},{138,-16}})));
    Buildings.Controls.Continuous.LimPID conPID4(
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      Ti=15,
      yMax=1,
      yMin=0,
      reverseAction=false,
      k=100,
      Td=5)
      annotation (Placement(transformation(extent={{134,-10},{122,2}})));
    Modelica.Blocks.Sources.RealExpression realExpression11(y=damExp.m_flow/
          damExp.m_flow_nominal)
      annotation (Placement(transformation(extent={{-146,-34},{-126,-14}})));
    Buildings.Controls.Continuous.LimPID conPID5(
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      yMax=1,
      yMin=0,
      reverseAction=false,
      k=30,
      Ti=15,
      Td=10)
      annotation (Placement(transformation(extent={{-118,-14},{-106,-2}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=damExp1.m_flow)
      annotation (Placement(transformation(extent={{-122,-70},{-102,-50}})));
    Buildings.Controls.Continuous.LimPID conPID6(
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      Ti=15,
      yMax=1,
      yMin=0,
      reverseAction=false,
      k=50,
      Td=10)
      annotation (Placement(transformation(extent={{112,-60},{100,-48}})));
    Buildings.Controls.Continuous.LimPID conPID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      yMax=1,
      yMin=0,
      reverseAction=false,
      k=40,
      Ti=50,
      Td=1)
      annotation (Placement(transformation(extent={{-54,22},{-42,34}})));
  equation

  public
    Buildings.Fluid.FixedResistances.PressureDrop res8(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=435,
      m_flow_nominal=0.261)
                      annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={-44,8})));
  equation
    C_h= C1*res4.m_flow+C2*res6.m_flow+C3*res8.m_flow "PM concentration of the return air";
    Q_h=res4.m_flow+res8.m_flow+res6.m_flow "Return air mass flow";

    if res2.m_flow< 0.00001 then
      C_s =0;
    else
      C_s= (C_x*res1.m_flow+C_h*Q_h)*(1-eta_z)/res2.m_flow;
    end if;

    GasRoom.V*der(C1)= (G_s_1-D)+(res3.m_flow*C_s*(1-eta_hp)+C3*ori.m_flow+ori5.m_flow*C2-C1*res0.m_flow-res4.m_flow*C1)/1.2*3600;
    GasRoom1.V*der(C2)= (G_s_2-D)+(res5.m_flow*C_s*(1-eta_hp)-ori5.m_flow*C2-ori1.m_flow*C2-C2*res01.m_flow-res6.m_flow*C2)/1.2*3600;
    GasRoom2.V*der(C3)= (G_s_3-D)+(res7.m_flow*C_s*(1-eta_hp)+ ori1.m_flow*C2-ori.m_flow*C3-C3*res02.m_flow-res8.m_flow*C3)/1.2*3600;

    connect(sinAir1.ports[1], res1.port_a)
      annotation (Line(points={{-84,70},{-84,72},{-72,72}},
                                                     color={0,127,255},
        thickness=1));
    connect(damExp.port_b, GasRoom.ports[1]) annotation (Line(points={{-10,-20},
            {-10,-24.5},{4,-24.5}},         color={0,127,255}));
    connect(GasRoom.ports[2], damExp1.port_a) annotation (Line(points={{4,-25.5},
            {-8,-25.5},{-8,-40}}, color={0,127,255}));
    connect(GasRoom.ports[3], res0.port_a) annotation (Line(points={{4,-26.5},{
            -2,-26.5},{-2,-46},{2,-46}},                   color={0,127,255}));
    connect(res0.port_b, sinAir2.ports[1]) annotation (Line(points={{12,-46},{
            34.6667,-46},{34.6667,-100}},   color={0,127,255}));
    connect(res1.port_b, res2.port_a)
      annotation (Line(points={{-60,72},{-52,72}}, color={0,127,255}));
    connect(fan11.port_a, res2.port_b)
      annotation (Line(points={{-36,72},{-38,72},{-38,72},{-40,72}},
                                                   color={0,127,255}));
    connect(damExp2.port_b, GasRoom1.ports[1]) annotation (Line(points={{52,-14},
            {52,-28.5},{60,-28.5}},       color={0,127,255}));
    connect(GasRoom1.ports[2], damExp3.port_a) annotation (Line(points={{60,
            -29.5},{50,-29.5},{50,-48}},
                                color={0,127,255}));
    connect(GasRoom1.ports[3], res01.port_a) annotation (Line(points={{60,-30.5},
            {60,-46},{62,-46}},                             color={0,127,255}));
    connect(res01.port_b, sinAir2.ports[2]) annotation (Line(points={{72,-46},{78,
            -46},{78,-70},{36,-70},{36,-100}},    color={0,127,255}));
    connect(fan11.port_b, res3.port_a) annotation (Line(points={{-20,72},{-8,72},{-8,70}},
                           color={0,127,255}));
    connect(res3.port_b, damExp.port_a)
      annotation (Line(points={{-8,58},{-8,-8},{-10,-8}},
                                                    color={0,127,255}));
    connect(damExp1.port_b, res4.port_a) annotation (Line(points={{-8,-52},{-8,
            -56},{-38,-56}},     color={0,127,255}));
    connect(res4.port_b, res1.port_b) annotation (Line(points={{-50,-56},{-56,-56},{-56,72},
            {-60,72}},               color={0,127,255}));
    connect(fan11.port_b, res5.port_a) annotation (Line(points={{-20,72},{12,72},{12,70}},
                           color={0,127,255}));
    connect(res5.port_b, damExp2.port_a) annotation (Line(points={{12,58},{12,0},
            {52,0},{52,-2}},     color={0,127,255}));
    connect(damExp3.port_b, res6.port_a) annotation (Line(points={{50,-60},{50,
            -68},{-38,-68}}, color={0,127,255}));
    connect(res6.port_b, res2.port_a) annotation (Line(points={{-50,-68},{-56,-68},{-56,72},
            {-52,72}},               color={0,127,255}));
    connect(fan11.port_b, res7.port_a) annotation (Line(points={{-20,72},{28,72},{28,70}},
                                                 color={0,127,255}));
    connect(res7.port_b, damExp4.port_a) annotation (Line(points={{28,58},{28,52}},
                                                         color={0,127,255}));
    connect(damExp4.port_b, GasRoom2.ports[1]) annotation (Line(points={{28,40},
            {28,37.5},{48,37.5}},                                    color={0,
            127,255}));
    connect(GasRoom2.ports[2], res02.port_a) annotation (Line(points={{48,36.5},
            {48,32},{42,32},{42,18},{66,18}},        color={0,127,255}));
    connect(sinAir2.ports[3], res02.port_b) annotation (Line(points={{37.3333,
            -100},{42,-100},{42,-72},{86,-72},{86,18},{76,18}}, color={0,127,
            255}));
    connect(GasRoom2.ports[3], damExp5.port_a) annotation (Line(points={{48,35.5},
            {28,35.5},{28,28}},                                    color={0,127,
            255}));
    connect(res8.port_a, damExp5.port_b) annotation (Line(points={{-38,8},{28,8},
            {28,16}},                       color={0,127,255}));
    connect(res8.port_b, res1.port_b) annotation (Line(points={{-50,8},{-56,8},{-56,72},{-60,
            72}},               color={0,127,255}));
    connect(GasRoom2.ports[4], ori.port_a) annotation (Line(points={{48,34.5},{
            0,34.5},{0,10}}, color={0,127,255}));
    connect(ori.port_b, GasRoom.ports[4]) annotation (Line(points={{0,-2},{0,
            -27.5},{4,-27.5}},
                          color={0,127,255}));
    connect(GasRoom1.ports[4], ori1.port_a) annotation (Line(points={{60,-31.5},
            {56,-31.5},{56,-2}},
                             color={0,127,255}));
    connect(ori1.port_b, GasRoom2.ports[5]) annotation (Line(points={{56,10},{
            56,14},{46,14},{46,33.5},{48,33.5}},
                                          color={0,127,255}));
    connect(GasRoom1.ports[5], ori5.port_a) annotation (Line(points={{60,-32.5},
            {48,-32.5},{48,-42},{34,-42}},
                                      color={0,127,255}));
    connect(ori5.port_b, GasRoom.ports[5]) annotation (Line(points={{22,-42},{2,
            -42},{2,-32},{4,-32},{4,-28.5}},       color={0,127,255}));
    connect(realExpression.y, realValue.numberPort)
      annotation (Line(points={{-49,44},{-31.5,44}}, color={0,0,127}));
    connect(realExpression1.y, realValue2.numberPort)
      annotation (Line(points={{-49,-2},{-31.5,-2}}, color={0,0,127}));
    connect(realExpression2.y, realValue3.numberPort)
      annotation (Line(points={{91,-14},{81.5,-14}}, color={0,0,127}));
    connect(senRelPre.port_b, GasRoom.ports[6]) annotation (Line(points={{6,-76},
            {-2,-76},{-2,-29.5},{4,-29.5}},
                                     color={0,127,255}));
    connect(GasRoom1.ports[6], senRelPre.port_a) annotation (Line(points={{60,
            -33.5},{32,-33.5},{32,-76},{26,-76}},
                                          color={0,127,255}));
    connect(senRelPre1.port_b, GasRoom.ports[7]) annotation (Line(points={{-46,-24},
            {-46,-30.5},{4,-30.5}},
                           color={0,127,255}));
    connect(senRelPre1.port_a, GasRoom2.ports[6]) annotation (Line(points={{-46,-4},
            {-46,-4},{-46,16},{-46,16},{-46,32.5},{48,32.5}},
                                                           color={0,127,255}));
    connect(GasRoom1.ports[7], senRelPre2.port_a) annotation (Line(points={{60,
            -34.5},{42,-34.5},{42,-4},{98,-4},{98,2}},
                                               color={0,127,255}));
    connect(senRelPre2.port_b, GasRoom2.ports[7]) annotation (Line(points={{98,22},
            {98,48},{36,48},{36,31.5},{48,31.5}},
                                               color={0,127,255}));
    connect(GasRoom.ports[8], senRelPre3.port_a) annotation (Line(points={{4,-31.5},
            {-82,-31.5},{-82,-68}},        color={0,127,255}));
    connect(senRelPre3.port_b, sinAir2.ports[4])
      annotation (Line(points={{-82,-88},{-22,-88},{-22,-100},{38.6667,-100}},
                                                         color={0,127,255}));
    connect(sinAir2.ports[5], senRelPre4.port_b)
      annotation (Line(points={{40,-100},{46,-100},{46,-80},{50,-80}},
                                                   color={0,127,255}));
    connect(senRelPre4.port_a, GasRoom1.ports[8]) annotation (Line(points={{70,
            -80},{70,-60},{56,-60},{56,-35.5},{60,-35.5}}, color={0,127,255}));
    connect(GasRoom2.ports[8], senRelPre5.port_a) annotation (Line(points={{48,
            30.5},{-94,30.5},{-94,14}}, color={0,127,255}));
    connect(senRelPre5.port_b, sinAir2.ports[6]) annotation (Line(points={{-94,-6},
            {-94,-100},{41.3333,-100}},   color={0,127,255}));
    connect(combiTimeTable.y[1], fan11.m_flow_in) annotation (Line(points={{-61,108},
            {-28,108},{-28,81.6}},                               color={0,0,127}));
    connect(combiTimeTable_huanchong.y[1], conPID2.u_s)
      annotation (Line(points={{73.2,86},{63.2,86}}, color={0,0,127}));
    connect(realExpression9.y, conPID2.u_m)
      annotation (Line(points={{65,64},{56,64},{56,78.8}}, color={0,0,127}));
    connect(conPID2.y, damExp4.y) annotation (Line(points={{49.4,86},{42,86},{42,
            46},{35.2,46}}, color={0,0,127}));
    connect(conPID4.y, damExp2.y) annotation (Line(points={{121.4,-4},{90,-4},{90,
            -8},{59.2,-8}}, color={0,0,127}));
    connect(realExpression10.y, conPID4.u_m) annotation (Line(points={{137,-26},{
            128,-26},{128,-11.2}}, color={0,0,127}));
    connect(combiTimeTable_wujun.y[1], conPID4.u_s)
      annotation (Line(points={{155.2,-4},{135.2,-4}}, color={0,0,127}));
    connect(conPID5.u_s, combiTimeTable_weisheng.y[1])
      annotation (Line(points={{-119.2,-8},{-135.2,-8}}, color={0,0,127}));
    connect(conPID5.y, damExp.y) annotation (Line(points={{-105.4,-8},{-62,-8},{
            -62,-14},{-17.2,-14}}, color={0,0,127}));
    connect(realExpression11.y, conPID5.u_m) annotation (Line(points={{-125,-24},
            {-112,-24},{-112,-15.2}}, color={0,0,127}));
    connect(realExpression6.y, conPID.u_s)
      annotation (Line(points={{-101,-46},{-73.2,-46}}, color={0,0,127}));
    connect(realExpression3.y, conPID.u_m) annotation (Line(points={{-101,-60},{
            -66,-60},{-66,-53.2}}, color={0,0,127}));
    connect(conPID.y, damExp1.y)
      annotation (Line(points={{-59.4,-46},{-15.2,-46}}, color={0,0,127}));
    connect(realExpression4.y, conPID6.u_m) annotation (Line(points={{121,-72},{
            106,-72},{106,-61.2}}, color={0,0,127}));
    connect(conPID6.y, damExp3.y)
      annotation (Line(points={{99.4,-54},{57.2,-54}}, color={0,0,127}));
    connect(realExpression7.y, conPID6.u_s)
      annotation (Line(points={{123,-54},{113.2,-54}}, color={0,0,127}));
    connect(conPID1.u_s, realExpression8.y) annotation (Line(points={{-55.2,28},{
            -62,28},{-62,30},{-65,30}}, color={0,0,127}));
    connect(realExpression5.y, conPID1.u_m) annotation (Line(points={{-67,18},{
            -62,18},{-62,20.8},{-48,20.8}}, color={0,0,127}));
    connect(conPID1.y, damExp5.y) annotation (Line(points={{-41.4,28},{-12,28},{
            -12,22},{20.8,22}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
              -140},{180,140}})),                                  Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-160,-140},{180,
              140}}),                                  graphics={
          Rectangle(
            extent={{-34,4},{28,-64}},
            lineColor={175,175,175},
            lineThickness=1),
          Rectangle(
            extent={{28,4},{88,-64}},
            lineColor={175,175,175},
            lineThickness=1),
          Rectangle(
            extent={{-34,54},{88,4}},
            lineColor={175,175,175},
            lineThickness=1),
          Rectangle(
            extent={{-106,-24},{-14,-58}},
            lineColor={0,127,255},
            lineThickness=1)}),
      Documentation(info="<html>
<p>Pressure and airflow control.</p>
<p style=\"margin-left: 60px;\">The Pressure of each room was controled by the return damper using the PID controllor. </p>
<p style=\"margin-left: 60px;\">The opening rate of the demper was adjust by considering both the difference of supply and return air and the pressure of the room.</p>
<p style=\"margin-left: 60px;\">The time cost of actuators for damper open was set.</p>
</html>"),
      experiment(StopTime=82800),
      uses(Buildings(version="7.0.0"), Modelica(version="3.2.2")),
               Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end fbs_0513;

  model fbs_0523
     package Medium = Buildings.Media.Air;
     parameter Real G_p=654603*60 "PM generation rate for each person";
     parameter Real C_x=10^9 "PM concentration of the fresh air";
     parameter Real eta_z=0.95 "total filter efficiency";
     parameter Real eta_hp=0.9997 "filter efficiency of the inlet air";

    // parameter Real Q_h=res4.m_flow+res8.m_flow+res6.m_flow "Return air mass flow";
     parameter Real D=0 "PM dropt rate";

     Real C1 "PM concteration of the bio test room";
     Real C2 "PM concteration of the no-germ room";
     Real C3 "PM concteration of the huanchong room";
     Real C_s "pm of supply air";
     Real C_h "PM concentration of the return air";
     Real Q_h "Return air mass flow";
     Real G_s_1= G_p*combiTimeTable.y[2] "pm diffusion source per min";
     Real G_s_2= G_p*combiTimeTable.y[3] "pm diffusion source per min";
     Real G_s_3= G_p*combiTimeTable.y[4] "pm diffusion source per min";

    Buildings.Fluid.Sources.Boundary_pT sinAir1(
      nPorts=1,
      redeclare package Medium = Medium,
      p(displayUnit="bar") = 100000,
      T=293.15) "Sink for water circuit"
      annotation (Placement(transformation(extent={{-104,60},{-84,80}})));
    Buildings.Fluid.Movers.FlowControlled_m_flow fan11(
      addPowerToMedium=false,
      redeclare package Medium = Medium,
      dp_nominal=1900,
      m_flow_nominal=0.77)                        annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=0,
          origin={-28,72})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      m_flow_nominal=0.237,
      riseTime=3)        annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={-10,-14})));
    Buildings.Fluid.MixingVolumes.MixingVolume GasRoom(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      m_flow_nominal=10,
      nPorts=8,
      T_start=273.15 + 20,
      V=17.82,
      redeclare package Medium = Medium,
      p_start(displayUnit="bar"))
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={14,-28})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp1(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=3,
      m_flow_nominal=0.235)
                         annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={-8,-46})));
    Buildings.Fluid.Sources.Boundary_pT sinAir2(
      redeclare package Medium = Medium,
      nPorts=6,
      p(displayUnit="bar") = 100000,
      T=293.15) "Sink for water circuit"
      annotation (Placement(transformation(extent={{10,10},{-10,-10}},
          rotation=-90,
          origin={38,-110})));
    Buildings.Fluid.FixedResistances.PressureDrop res1(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=500,
      m_flow_nominal=0.06)
      annotation (Placement(transformation(extent={{-72,66},{-60,78}})));
    Buildings.Fluid.FixedResistances.PressureDrop res0(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=30,
      m_flow_nominal=0.0136)
      annotation (Placement(transformation(extent={{2,-52},{12,-40}})));
    Buildings.Fluid.FixedResistances.PressureDrop res2(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=900,
      m_flow_nominal=0.77)
      annotation (Placement(transformation(extent={{-52,66},{-40,78}})));
    Buildings.Fluid.MixingVolumes.MixingVolume GasRoom1(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      m_flow_nominal=10,
      nPorts=8,
      T_start=273.15 + 20,
      redeclare package Medium = Medium,
      p_start(displayUnit="bar"),
      V=18.6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={70,-32})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp2(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=3,
      m_flow_nominal=0.24)
                         annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=90,
          origin={52,-8})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp3(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=3,
      m_flow_nominal=0.214)
                         annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=90,
          origin={50,-54})));
    Buildings.Fluid.FixedResistances.PressureDrop res01(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=40,
      m_flow_nominal=0.0142)
      annotation (Placement(transformation(extent={{62,-52},{72,-40}})));
    Buildings.Fluid.FixedResistances.PressureDrop res3(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=370,
      m_flow_nominal=0.237)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={-8,64})));
    Buildings.Fluid.FixedResistances.PressureDrop res4(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=430,
      m_flow_nominal=0.235)
                           annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={-44,-56})));
    Buildings.Fluid.FixedResistances.PressureDrop res5(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=360,
      m_flow_nominal=0.24)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={12,64})));
    Buildings.Fluid.FixedResistances.PressureDrop res6(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=440,
      m_flow_nominal=0.214)
                           annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={-44,-68})));
    Buildings.Fluid.MixingVolumes.MixingVolume GasRoom2(
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      m_flow_nominal=10,
      nPorts=8,
      T_start=273.15 + 20,
      redeclare package Medium = Medium,
      p_start(displayUnit="bar"),
      V=21.1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={58,34})));
    Buildings.Fluid.FixedResistances.PressureDrop res7(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=365,
      m_flow_nominal=0.293)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=-90,
          origin={28,64})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp4(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      m_flow_nominal=0.293,
      riseTime=3)        annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=90,
          origin={28,46})));
    Buildings.Fluid.FixedResistances.PressureDrop res02(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=35,
      m_flow_nominal=0.032)
      annotation (Placement(transformation(extent={{66,12},{76,24}})));
    Buildings.Fluid.Actuators.Dampers.Exponential damExp5(
      redeclare package Medium = Medium,
      dpFixed_nominal=0,
      dpDamper_nominal=100,
      riseTime=3,
      m_flow_nominal=0.261)
                         annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={28,22})));
    Buildings.Airflow.Multizone.Orifice ori(redeclare package Medium = Medium, A=0.004222)
      annotation (Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=-90,
          origin={0,4})));
    Buildings.Airflow.Multizone.Orifice ori1(redeclare package Medium = Medium, A=
          0.004222)
               annotation (Placement(transformation(
          extent={{6,6},{-6,-6}},
          rotation=-90,
          origin={56,4})));
    Buildings.Airflow.Multizone.Orifice ori5(redeclare package Medium = Medium, A=
          0.00078)
               annotation (Placement(transformation(
          extent={{-6,6},{6,-6}},
          rotation=180,
          origin={28,-42})));

    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,
          0.231,0,0,0; 3600,0.231,0,0,0; 7200,0.231,0,0,0; 10800,0.231,0,0,0;
          14400,0.231,0,0,0; 18000,0.231,0,0,0; 21600,0.231,0,0,0; 25200,0.231,0,
          0,0; 28800,0.4209,0,0,0; 28860,0.4209,0,0,1.5; 28920,0.4209,0,0,3;
          28980,0.4209,0,0,2.5; 29040,0.4209,0,0,2.2; 29100,0.4209,0,0,1.8; 29160,
          0.4209,0,0,1.7; 29220,0.4209,0,0,1.65; 30600,0.424933333,0,0,0; 30660,
          0.424933333,0.5,1,0; 30720,0.424933333,1,2,0; 30780,0.424933333,
          0.833333333,1.666666667,0; 30840,0.424933333,0.733333333,1.466666667,0;
          30900,0.424933333,0.6,1.2,0; 30960,0.424933333,0.566666667,1.133333333,
          0; 31020,0.424933333,0.55,1.1,0; 32400,0.424933333,0.55,1.1,0; 36000,
          0.4648,0.55,1.1,0; 36060,0.4648,0.55,1.1,0.5; 36120,0.4648,0.55,1.1,1;
          36180,0.4648,0.55,1.1,0.833333333; 36240,0.4648,0.55,1.1,0.733333333;
          36300,0.4648,0.55,1.1,0.6; 36360,0.4648,0.55,1.1,0.566666667; 36420,
          0.4648,0.55,1.1,0.55; 37800,0.424933333,0.55,1.1,0; 39600,0.424933333,
          0.55,1.1,0; 43200,0.614833333,0,0,0; 43260,0.4209,0,0,1.5; 43320,0.4209,
          0,0,3; 43380,0.4209,0,0,2.5; 43440,0.4209,0,0,2.2; 43500,0.4209,0,0,1.8;
          43560,0.4209,0,0,1.7; 43620,0.4209,0,0,1.65; 45000,0.231,0,0,0; 48600,
          0.424933333,0.6,0.5,0; 48660,0.424933333,1.7,1,0; 48720,0.424933333,
          1.666666667,0.833333333,0; 48780,0.424933333,1.466666667,0.733333333,0;
          48840,0.424933333,1.2,0.6,0; 48900,0.424933333,1.133333333,0.566666667,
          0; 48960,0.424933333,1.1,0.55,0; 49020,0.424933333,1.1,0.55,0; 50400,
          0.424933333,1.1,0.55,0; 54000,0.4648,1.1,0.55,0; 54060,0.4648,1.1,0.55,
          0.5; 54120,0.4648,1.1,0.55,0.8; 54180,0.4648,1.1,0.55,0.733333333;
          54240,0.4648,1.1,0.55,0.733333333; 54300,0.4648,1.1,0.55,0.6; 54360,
          0.4648,1.1,0.55,0.566666667; 54420,0.4648,1.1,0.55,0.55; 55800,
          0.424933333,1.1,0.55,0; 57600,0.424933333,1.1,0.55,0; 61200,0.424933333,
          1.1,0.55,0; 64800,0.614833333,0,0,0; 64860,0.4209,0,0,1.5; 64920,0.4209,
          0,0,3; 64980,0.4209,0,0,2.5; 65040,0.4209,0,0,2.2; 65100,0.4209,0,0,1.8;
          65160,0.4209,0,0,1.7; 65220,0.4209,0,0,1.65; 66600,0.231,0,0,0; 68400,
          0.231,0,0,0; 72000,0.231,0,0,0; 75600,0.231,0,0,0; 79200,0.231,0,0,0;
          82800,0.231,0,0,0])
      annotation (Placement(transformation(extent={{-80,94},{-60,114}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue
      annotation (Placement(transformation(extent={{-30,34},{-10,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=C3)
      annotation (Placement(transformation(extent={{-70,34},{-50,54}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=C1)
      annotation (Placement(transformation(extent={{-70,-12},{-50,8}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue2
      annotation (Placement(transformation(extent={{-30,-12},{-10,8}})));
    Modelica.Blocks.Sources.RealExpression realExpression2(y=C2)
      annotation (Placement(transformation(extent={{112,-24},{92,-4}})));
    Modelica.Blocks.Interaction.Show.RealValue realValue3
      annotation (Placement(transformation(extent={{80,-24},{60,-4}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{26,-86},{6,-66}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre1(redeclare package
        Medium =                                                                   Medium)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-46,-14})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre2(redeclare package
        Medium =                                                                   Medium)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={98,12})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre3(redeclare package
        Medium =                                                                   Medium)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-82,-70})));
    Buildings.Controls.Continuous.LimPID conPID(
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      Ti=15,
      yMax=1,
      yMin=0,
      reverseAction=false,
      k=50,
      Td=10)
      annotation (Placement(transformation(extent={{-72,-52},{-60,-40}})));
    Modelica.Blocks.Sources.RealExpression realExpression4(y=damExp3.m_flow)
      annotation (Placement(transformation(extent={{142,-82},{122,-62}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre4(
                                                       redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{70,-90},{50,-70}})));
    Modelica.Blocks.Sources.RealExpression realExpression5(y=damExp5.m_flow)
      annotation (Placement(transformation(extent={{-88,8},{-68,28}})));
    Buildings.Fluid.Sensors.RelativePressure senRelPre5(
                                                       redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-94,4})));
    Modelica.Blocks.Sources.RealExpression realExpression6(y=damExp.m_flow -
          0.002)
      annotation (Placement(transformation(extent={{-122,-56},{-102,-36}})));
    Modelica.Blocks.Sources.RealExpression realExpression7(y=damExp2.m_flow -
          0.026)
      annotation (Placement(transformation(extent={{144,-64},{124,-44}})));
    Modelica.Blocks.Sources.RealExpression realExpression8(y=damExp4.m_flow -
          0.032)
      annotation (Placement(transformation(extent={{-86,20},{-66,40}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_huanchong(smoothness=
          Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,0.3; 3600,
          0.3; 7200,0.3; 10800,0.3; 14400,0.3; 18000,0.3; 21600,0.3; 25200,0.3;
          28800,0.947386364; 28860,0.947386364; 28920,0.947386364; 28980,
          0.947386364; 29040,0.947386364; 29100,0.947386364; 29160,0.947386364;
          29220,0.947386364; 30600,0.3; 30660,0.3; 30720,0.3; 30780,0.3; 30840,
          0.3; 30900,0.3; 30960,0.3; 31020,0.3; 32400,0.3; 36000,0.435909091;
          36060,0.435909091; 36120,0.435909091; 36180,0.435909091; 36240,
          0.435909091; 36300,0.435909091; 36360,0.435909091; 36420,0.435909091;
          37800,0.3; 39600,0.3; 43200,0.947386364; 43260,0.947386364; 43320,
          0.947386364; 43380,0.947386364; 43440,0.947386364; 43500,0.947386364;
          43560,0.947386364; 43620,0.947386364; 45000,0.3; 48600,0.3; 48660,0.3;
          48720,0.3; 48780,0.3; 48840,0.3; 48900,0.3; 48960,0.3; 49020,0.3; 50400,
          0.3; 54000,0.435909091; 54060,0.435909091; 54120,0.435909091; 54180,
          0.435909091; 54240,0.435909091; 54300,0.435909091; 54360,0.435909091;
          54420,0.435909091; 55800,0.3; 57600,0.3; 61200,0.3; 64800,0.947386364;
          64860,0.947386364; 64920,0.947386364; 64980,0.947386364; 65040,
          0.947386364; 65100,0.947386364; 65160,0.947386364; 65220,0.947386364;
          66600,0.3; 68400,0.3; 72000,0.3; 75600,0.3; 79200,0.3; 82800,0.3])
      annotation (Placement(transformation(extent={{90,78},{74,94}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_huanchong_weisheng(
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,
          0.3; 3600,0.3; 7200,0.3; 10800,0.3; 14400,0.3; 18000,0.3; 21600,0.3;
          25200,0.3; 28800,0.3; 28860,0.3; 28920,0.3; 28980,0.3; 29040,0.3; 29100,
          0.3; 29160,0.3; 29220,0.3; 30600,0.54028169; 30660,0.54028169; 30720,
          0.54028169; 30780,0.54028169; 30840,0.54028169; 30900,0.54028169; 30960,
          0.54028169; 31020,0.54028169; 32400,0.54028169; 36000,0.54028169; 36060,
          0.54028169; 36120,0.54028169; 36180,0.54028169; 36240,0.54028169; 36300,
          0.54028169; 36360,0.54028169; 36420,0.54028169; 37800,0.54028169; 39600,
          0.54028169; 43200,0.54028169; 43260,0.3; 43320,0.3; 43380,0.3; 43440,
          0.3; 43500,0.3; 43560,0.3; 43620,0.3; 45000,0.3; 48600,0.883380282;
          48660,0.883380282; 48720,0.883380282; 48780,0.883380282; 48840,
          0.883380282; 48900,0.883380282; 48960,0.883380282; 49020,0.883380282;
          50400,0.883380282; 54000,0.883380282; 54060,0.883380282; 54120,
          0.883380282; 54180,0.883380282; 54240,0.883380282; 54300,0.883380282;
          54360,0.883380282; 54420,0.883380282; 55800,0.883380282; 57600,
          0.883380282; 61200,0.883380282; 64800,0.883380282; 64860,0.3; 64920,0.3;
          64980,0.3; 65040,0.3; 65100,0.3; 65160,0.3; 65220,0.3; 66600,0.3; 68400,
          0.3; 72000,0.3; 75600,0.3; 79200,0.3; 82800,0.3])
      annotation (Placement(transformation(extent={{-152,-16},{-136,0}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable_huanchong_wujun(
        smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments, table=[0,
          0.3; 3600,0.3; 7200,0.3; 10800,0.3; 14400,0.3; 18000,0.3; 21600,0.3;
          25200,0.3; 28800,0.3; 28860,0.3; 28920,0.3; 28980,0.3; 29040,0.3; 29100,
          0.3; 29160,0.3; 29220,0.3; 30600,0.871111111; 30660,0.871111111; 30720,
          0.871111111; 30780,0.871111111; 30840,0.871111111; 30900,0.871111111;
          30960,0.871111111; 31020,0.871111111; 32400,0.871111111; 36000,
          0.871111111; 36060,0.871111111; 36120,0.871111111; 36180,0.871111111;
          36240,0.871111111; 36300,0.871111111; 36360,0.871111111; 36420,
          0.871111111; 37800,0.871111111; 39600,0.871111111; 43200,0.871111111;
          43260,0.3; 43320,0.3; 43380,0.3; 43440,0.3; 43500,0.3; 43560,0.3; 43620,
          0.3; 45000,0.3; 48600,0.532777778; 48660,0.532777778; 48720,0.532777778;
          48780,0.532777778; 48840,0.532777778; 48900,0.532777778; 48960,
          0.532777778; 49020,0.532777778; 50400,0.532777778; 54000,0.532777778;
          54060,0.532777778; 54120,0.532777778; 54180,0.532777778; 54240,
          0.532777778; 54300,0.532777778; 54360,0.532777778; 54420,0.532777778;
          55800,0.532777778; 57600,0.532777778; 61200,0.532777778; 64800,
          0.532777778; 64860,0.3; 64920,0.3; 64980,0.3; 65040,0.3; 65100,0.3;
          65160,0.3; 65220,0.3; 66600,0.3; 68400,0.3; 72000,0.3; 75600,0.3; 79200,
          0.3; 82800,0.3])
      annotation (Placement(transformation(extent={{170,-12},{154,4}})));
    Buildings.Controls.Continuous.LimPID conPID2(
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      yMax=1,
      yMin=0,
      reverseAction=false,
      k=150,
      Ti=30,
      Td=5)
      annotation (Placement(transformation(extent={{62,80},{50,92}})));
    Modelica.Blocks.Sources.RealExpression realExpression9(y=damExp4.m_flow/
          damExp4.m_flow_nominal)
      annotation (Placement(transformation(extent={{86,54},{66,74}})));
    Modelica.Blocks.Sources.RealExpression realExpression10(y=damExp2.m_flow/
          damExp2.m_flow_nominal)
      annotation (Placement(transformation(extent={{158,-36},{138,-16}})));
    Buildings.Controls.Continuous.LimPID conPID4(
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      yMax=1,
      yMin=0,
      reverseAction=false,
      Td=5,
      k=100,
      Ti=50)
      annotation (Placement(transformation(extent={{134,-10},{122,2}})));
    Modelica.Blocks.Sources.RealExpression realExpression11(y=damExp.m_flow/
          damExp.m_flow_nominal)
      annotation (Placement(transformation(extent={{-146,-34},{-126,-14}})));
    Buildings.Controls.Continuous.LimPID conPID5(
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      yMax=1,
      yMin=0,
      reverseAction=false,
      Td=5,
      k=150,
      Ti=30)
      annotation (Placement(transformation(extent={{-118,-14},{-106,-2}})));
    Modelica.Blocks.Sources.RealExpression realExpression3(y=damExp1.m_flow)
      annotation (Placement(transformation(extent={{-122,-70},{-102,-50}})));
    Buildings.Controls.Continuous.LimPID conPID6(
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      Ti=15,
      yMax=1,
      yMin=0,
      reverseAction=false,
      k=50,
      Td=10)
      annotation (Placement(transformation(extent={{112,-60},{100,-48}})));
    Buildings.Controls.Continuous.LimPID conPID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PID,
      yMax=1,
      yMin=0,
      reverseAction=false,
      k=40,
      Ti=50,
      Td=1)
      annotation (Placement(transformation(extent={{-54,22},{-42,34}})));
  equation

  public
    Buildings.Fluid.FixedResistances.PressureDrop res8(
      from_dp=true,
      redeclare package Medium = Medium,
      dp_nominal=435,
      m_flow_nominal=0.261)
                      annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=0,
          origin={-44,8})));
  equation
    C_h= C1*res4.m_flow+C2*res6.m_flow+C3*res8.m_flow "PM concentration of the return air";
    Q_h=res4.m_flow+res8.m_flow+res6.m_flow "Return air mass flow";

    if res2.m_flow< 0.00001 then
      C_s =0;
    else
      C_s= (C_x*res1.m_flow+C_h*Q_h)*(1-eta_z)/res2.m_flow;
    end if;

    GasRoom.V*der(C1)= (G_s_1-D)+(res3.m_flow*C_s*(1-eta_hp)+C3*ori.m_flow+ori5.m_flow*C2-C1*res0.m_flow-res4.m_flow*C1)/1.2*3600;
    GasRoom1.V*der(C2)= (G_s_2-D)+(res5.m_flow*C_s*(1-eta_hp)-ori5.m_flow*C2-ori1.m_flow*C2-C2*res01.m_flow-res6.m_flow*C2)/1.2*3600;
    GasRoom2.V*der(C3)= (G_s_3-D)+(res7.m_flow*C_s*(1-eta_hp)+ ori1.m_flow*C2-ori.m_flow*C3-C3*res02.m_flow-res8.m_flow*C3)/1.2*3600;

    connect(sinAir1.ports[1], res1.port_a)
      annotation (Line(points={{-84,70},{-84,72},{-72,72}},
                                                     color={0,127,255},
        thickness=1));
    connect(damExp.port_b, GasRoom.ports[1]) annotation (Line(points={{-10,-20},{
            -10,-24.5},{4,-24.5}},          color={0,127,255}));
    connect(GasRoom.ports[2], damExp1.port_a) annotation (Line(points={{4,-25.5},
            {-8,-25.5},{-8,-40}}, color={0,127,255}));
    connect(GasRoom.ports[3], res0.port_a) annotation (Line(points={{4,-26.5},{
            -2,-26.5},{-2,-46},{2,-46}},                   color={0,127,255}));
    connect(res0.port_b, sinAir2.ports[1]) annotation (Line(points={{12,-46},{
            34.6667,-46},{34.6667,-100}},   color={0,127,255}));
    connect(res1.port_b, res2.port_a)
      annotation (Line(points={{-60,72},{-52,72}}, color={0,127,255}));
    connect(fan11.port_a, res2.port_b)
      annotation (Line(points={{-36,72},{-38,72},{-38,72},{-40,72}},
                                                   color={0,127,255}));
    connect(damExp2.port_b, GasRoom1.ports[1]) annotation (Line(points={{52,-14},
            {52,-28.5},{60,-28.5}},       color={0,127,255}));
    connect(GasRoom1.ports[2], damExp3.port_a) annotation (Line(points={{60,
            -29.5},{50,-29.5},{50,-48}},
                                color={0,127,255}));
    connect(GasRoom1.ports[3], res01.port_a) annotation (Line(points={{60,-30.5},
            {60,-46},{62,-46}},                             color={0,127,255}));
    connect(res01.port_b, sinAir2.ports[2]) annotation (Line(points={{72,-46},{78,
            -46},{78,-70},{36,-70},{36,-100}},    color={0,127,255}));
    connect(fan11.port_b, res3.port_a) annotation (Line(points={{-20,72},{-8,72},{-8,70}},
                           color={0,127,255}));
    connect(res3.port_b, damExp.port_a)
      annotation (Line(points={{-8,58},{-8,-8},{-10,-8}},
                                                    color={0,127,255}));
    connect(damExp1.port_b, res4.port_a) annotation (Line(points={{-8,-52},{-8,
            -56},{-38,-56}},     color={0,127,255}));
    connect(res4.port_b, res1.port_b) annotation (Line(points={{-50,-56},{-56,-56},{-56,72},
            {-60,72}},               color={0,127,255}));
    connect(fan11.port_b, res5.port_a) annotation (Line(points={{-20,72},{12,72},{12,70}},
                           color={0,127,255}));
    connect(res5.port_b, damExp2.port_a) annotation (Line(points={{12,58},{12,0},
            {52,0},{52,-2}},     color={0,127,255}));
    connect(damExp3.port_b, res6.port_a) annotation (Line(points={{50,-60},{50,
            -68},{-38,-68}}, color={0,127,255}));
    connect(res6.port_b, res2.port_a) annotation (Line(points={{-50,-68},{-56,-68},{-56,72},
            {-52,72}},               color={0,127,255}));
    connect(fan11.port_b, res7.port_a) annotation (Line(points={{-20,72},{28,72},{28,70}},
                                                 color={0,127,255}));
    connect(res7.port_b, damExp4.port_a) annotation (Line(points={{28,58},{28,52}},
                                                         color={0,127,255}));
    connect(damExp4.port_b, GasRoom2.ports[1]) annotation (Line(points={{28,40},
            {28,37.5},{48,37.5}},                                    color={0,
            127,255}));
    connect(GasRoom2.ports[2], res02.port_a) annotation (Line(points={{48,36.5},
            {48,32},{42,32},{42,18},{66,18}},        color={0,127,255}));
    connect(sinAir2.ports[3], res02.port_b) annotation (Line(points={{37.3333,
            -100},{42,-100},{42,-72},{86,-72},{86,18},{76,18}}, color={0,127,
            255}));
    connect(GasRoom2.ports[3], damExp5.port_a) annotation (Line(points={{48,35.5},
            {28,35.5},{28,28}},                                    color={0,127,
            255}));
    connect(res8.port_a, damExp5.port_b) annotation (Line(points={{-38,8},{28,8},
            {28,16}},                       color={0,127,255}));
    connect(res8.port_b, res1.port_b) annotation (Line(points={{-50,8},{-56,8},{-56,72},{-60,
            72}},               color={0,127,255}));
    connect(GasRoom2.ports[4], ori.port_a) annotation (Line(points={{48,34.5},{
            0,34.5},{0,10}}, color={0,127,255}));
    connect(ori.port_b, GasRoom.ports[4]) annotation (Line(points={{0,-2},{0,
            -27.5},{4,-27.5}},
                          color={0,127,255}));
    connect(GasRoom1.ports[4], ori1.port_a) annotation (Line(points={{60,-31.5},
            {56,-31.5},{56,-2}},
                             color={0,127,255}));
    connect(ori1.port_b, GasRoom2.ports[5]) annotation (Line(points={{56,10},{
            56,14},{46,14},{46,33.5},{48,33.5}},
                                          color={0,127,255}));
    connect(GasRoom1.ports[5], ori5.port_a) annotation (Line(points={{60,-32.5},
            {48,-32.5},{48,-42},{34,-42}},
                                      color={0,127,255}));
    connect(ori5.port_b, GasRoom.ports[5]) annotation (Line(points={{22,-42},{2,
            -42},{2,-32},{4,-32},{4,-28.5}},       color={0,127,255}));
    connect(realExpression.y, realValue.numberPort)
      annotation (Line(points={{-49,44},{-31.5,44}}, color={0,0,127}));
    connect(realExpression1.y, realValue2.numberPort)
      annotation (Line(points={{-49,-2},{-31.5,-2}}, color={0,0,127}));
    connect(realExpression2.y, realValue3.numberPort)
      annotation (Line(points={{91,-14},{81.5,-14}}, color={0,0,127}));
    connect(senRelPre.port_b, GasRoom.ports[6]) annotation (Line(points={{6,-76},
            {-2,-76},{-2,-29.5},{4,-29.5}},
                                     color={0,127,255}));
    connect(GasRoom1.ports[6], senRelPre.port_a) annotation (Line(points={{60,
            -33.5},{32,-33.5},{32,-76},{26,-76}},
                                          color={0,127,255}));
    connect(senRelPre1.port_b, GasRoom.ports[7]) annotation (Line(points={{-46,-24},
            {-46,-30.5},{4,-30.5}},
                           color={0,127,255}));
    connect(senRelPre1.port_a, GasRoom2.ports[6]) annotation (Line(points={{-46,-4},
            {-46,-4},{-46,16},{-46,16},{-46,32.5},{48,32.5}},
                                                           color={0,127,255}));
    connect(GasRoom1.ports[7], senRelPre2.port_a) annotation (Line(points={{60,
            -34.5},{42,-34.5},{42,-4},{98,-4},{98,2}},
                                               color={0,127,255}));
    connect(senRelPre2.port_b, GasRoom2.ports[7]) annotation (Line(points={{98,22},
            {98,48},{36,48},{36,31.5},{48,31.5}},
                                               color={0,127,255}));
    connect(GasRoom.ports[8], senRelPre3.port_a) annotation (Line(points={{4,
            -31.5},{-82,-31.5},{-82,-60}}, color={0,127,255}));
    connect(senRelPre3.port_b, sinAir2.ports[4])
      annotation (Line(points={{-82,-80},{-22,-80},{-22,-100},{38.6667,-100}},
                                                         color={0,127,255}));
    connect(sinAir2.ports[5], senRelPre4.port_b)
      annotation (Line(points={{40,-100},{46,-100},{46,-80},{50,-80}},
                                                   color={0,127,255}));
    connect(senRelPre4.port_a, GasRoom1.ports[8]) annotation (Line(points={{70,
            -80},{70,-60},{56,-60},{56,-35.5},{60,-35.5}}, color={0,127,255}));
    connect(GasRoom2.ports[8], senRelPre5.port_a) annotation (Line(points={{48,
            30.5},{-94,30.5},{-94,14}}, color={0,127,255}));
    connect(senRelPre5.port_b, sinAir2.ports[6]) annotation (Line(points={{-94,-6},
            {-94,-100},{41.3333,-100}},   color={0,127,255}));
    connect(combiTimeTable.y[1], fan11.m_flow_in) annotation (Line(points={{-59,104},
            {-28,104},{-28,81.6}},                               color={0,0,127}));
    connect(combiTimeTable_huanchong.y[1], conPID2.u_s)
      annotation (Line(points={{73.2,86},{63.2,86}}, color={0,0,127}));
    connect(realExpression9.y, conPID2.u_m)
      annotation (Line(points={{65,64},{56,64},{56,78.8}}, color={0,0,127}));
    connect(conPID2.y, damExp4.y) annotation (Line(points={{49.4,86},{42,86},{42,
            46},{35.2,46}}, color={0,0,127}));
    connect(conPID4.y, damExp2.y) annotation (Line(points={{121.4,-4},{90,-4},{90,
            -8},{59.2,-8}}, color={0,0,127}));
    connect(realExpression10.y, conPID4.u_m) annotation (Line(points={{137,-26},{
            128,-26},{128,-11.2}}, color={0,0,127}));
    connect(combiTimeTable_huanchong_wujun.y[1], conPID4.u_s)
      annotation (Line(points={{153.2,-4},{135.2,-4}}, color={0,0,127}));
    connect(conPID5.u_s, combiTimeTable_huanchong_weisheng.y[1])
      annotation (Line(points={{-119.2,-8},{-135.2,-8}}, color={0,0,127}));
    connect(conPID5.y, damExp.y) annotation (Line(points={{-105.4,-8},{-62,-8},{
            -62,-14},{-17.2,-14}}, color={0,0,127}));
    connect(realExpression11.y, conPID5.u_m) annotation (Line(points={{-125,-24},
            {-112,-24},{-112,-15.2}}, color={0,0,127}));
    connect(realExpression6.y, conPID.u_s)
      annotation (Line(points={{-101,-46},{-73.2,-46}}, color={0,0,127}));
    connect(realExpression3.y, conPID.u_m) annotation (Line(points={{-101,-60},{
            -66,-60},{-66,-53.2}}, color={0,0,127}));
    connect(conPID.y, damExp1.y)
      annotation (Line(points={{-59.4,-46},{-15.2,-46}}, color={0,0,127}));
    connect(realExpression4.y, conPID6.u_m) annotation (Line(points={{121,-72},{
            106,-72},{106,-61.2}}, color={0,0,127}));
    connect(conPID6.y, damExp3.y)
      annotation (Line(points={{99.4,-54},{57.2,-54}}, color={0,0,127}));
    connect(realExpression7.y, conPID6.u_s)
      annotation (Line(points={{123,-54},{113.2,-54}}, color={0,0,127}));
    connect(conPID1.u_s, realExpression8.y) annotation (Line(points={{-55.2,28},{
            -62,28},{-62,30},{-65,30}}, color={0,0,127}));
    connect(realExpression5.y, conPID1.u_m) annotation (Line(points={{-67,18},{
            -62,18},{-62,20.8},{-48,20.8}}, color={0,0,127}));
    connect(conPID1.y, damExp5.y) annotation (Line(points={{-41.4,28},{-12,28},{
            -12,22},{20.8,22}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
              -140},{180,120}})),                                  Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-160,-140},{180,
              120}}),                                  graphics={
          Rectangle(
            extent={{-34,4},{28,-64}},
            lineColor={175,175,175},
            lineThickness=1),
          Rectangle(
            extent={{28,4},{88,-64}},
            lineColor={175,175,175},
            lineThickness=1),
          Rectangle(
            extent={{-34,54},{88,4}},
            lineColor={175,175,175},
            lineThickness=1),
          Rectangle(
            extent={{-106,-24},{-14,-58}},
            lineColor={0,127,255},
            lineThickness=1)}),
      Documentation(info="<html>
<p>Pressure and airflow control.</p>
<p style=\"margin-left: 60px;\">The Pressure of each room was controled by the return damper using the PID controllor. </p>
<p style=\"margin-left: 60px;\">The opening rate of the demper was adjust by considering both the difference of supply and return air and the pressure of the room.</p>
<p style=\"margin-left: 60px;\">The time cost of actuators for damper open was set.</p>
</html>"),
      experiment(StopTime=82800));
  end fbs_0523;
  annotation (uses(Buildings(version="7.0.0"), Modelica(version="3.2.2")));
end DQLVentilation;
