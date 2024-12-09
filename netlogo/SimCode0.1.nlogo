;; NetLogo-Code zur Simulation des Tumorwachstums mit der Gompertz-Funktion 

 

globals [ 

  scaling_tumor         ;; Skalierungsfaktor für die Tumorgröße 

  control_start_growth         ;; Parameter zur Steuerung des anfänglichen Wachstums 

  ctrl_stop_growth         ;; Parameter zur Steuerung der Abbremsung des Wachstums 

  time         ;; Zeitvariable für die Simulation 

] 

 

patches-own [ 

  nutrients ;; Nährstoffkonzentration in der Zelle 

  tumor     ;; Tumorstatus der Zelle (true/false) 

] 

 

;; Setup der Simulation 

to setup 

  clear-all 

  set scaling_tumor 1000  ;; Beispielwert für maximale Tumorgröße 

  set control_start_growth 1     ;; Beispielwert für Wachstumssteuerung 

  set ctrl_stop_growth 0.1   ;; Beispielwert für Abbremsung des Wachstums 

  set time 0 

   

  ;; Nährstoffe zufällig verteilen 

  ask patches [ 

    set nutrients random-float 1.0  ;; Nährstoffgehalt zwischen 0 und 1 

    set tumor false                 ;; Startzustand: Keine Tumorzelle 

  ] 

   

  ;; Tumor initialisieren in der Mitte des Feldes 

  ask patch 0 0 [ 

    set tumor true 

  ] 

   

  reset-ticks 

end 

 

;; Hauptschleife der Simulation 

to go 

  ;; Tumorwachstum berechnen mit der Gompertz-Funktion 

  let tumor-size scaling_tumor * exp (- control_start_growth * exp (- ctrl_stop_growth * time)) 

  set time time + 1 

   

  ;; Tumorwachstum und -ausbreitung 

  ask patches with [tumor = true] [ 

    ;; Tumor wächst abhängig von der Nährstoffkonzentration 

    if nutrients > random-float 1.0 [ 

      let nearby-patches neighbors with [tumor = false] 

      if any? nearby-patches [ 

        ask one-of nearby-patches [ 

          set tumor true 

          set nutrients nutrients - 0.1  ;; Nährstoffe werden verbraucht 

        ] 

      ] 

    ] 

  ] 

   

  ;; Visualisierung: Tumorzellen rot, gesunde Zellen grün 

  ask patches [ 

    ifelse tumor [ 

      set pcolor red - (nutrients * 50) 

    ] [ 

      set pcolor green - (nutrients * 50) 

    ] 

  ] 

   

  tick 

end 
