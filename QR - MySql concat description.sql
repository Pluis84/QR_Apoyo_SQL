# SP ANTERIOR:

SELECT 	# date_format(FCH_INVOQE,'%Y/%m/%d') as _fecha
			date_format(FCH_INVOQE,'%d-%M') as _fecha
			,concat(CDG_ERROR,' - ',NMB_WEBSERVICE) as '_err_ws'
			,ifnull(format(count(1),0,'de_DE'),0) as _count
            # ,ifnull(count(1),0) as _count
	FROM panel_cdr.monitor_services
    where NMB_WEBSERVICE = _webServices -- 'ListParty' -- 'ModifyParty'
    and CDG_ERROR != 0
	group by CDG_ERROR, DSC_ERROR, NMB_WEBSERVICE, _fecha
	order by _fecha, _err_ws, _count





# MODIFICA LA DESCRIPCION DEL ERROR PARA EL MONITOREO DE SERVICIOS
SELECT 		date_format(FCH_INVOQE,'%d-%M') as _fecha  			
            ,case when DSC_ERROR is null then concat(CDG_ERROR ,' - ',"Error no identificado") else
				concat(CDG_ERROR,' - ',            
					left( DSC_ERROR,
						locate(' ',DSC_ERROR)) 
					
			,
                    left(
					substr( DSC_ERROR,
							locate(' ',(DSC_ERROR))+1)
					,
					locate(' ',
					substr((DSC_ERROR),
							locate(' ',(DSC_ERROR))+1) 
					)
					)
			,
            
					left(
					substr(substr( DSC_ERROR
									,
									locate(' ',DSC_ERROR)+1
									),
					
					locate(' ',
						substr( DSC_ERROR
									,
									locate(' ',DSC_ERROR)+1
									)
							
							
						
						)+1) 
						
						
				,
				
					locate(' ',
					substr(substr( DSC_ERROR
								,
								locate(' ',DSC_ERROR)+1
								),
				
				locate(' ',
					substr( DSC_ERROR
								,
								locate(' ',DSC_ERROR)+1
								)
						
						
					
					)+1)
					
						
					)
				)
            ) end as '_err_ws' 
            
			,ifnull(format(count(1),0,'de_DE'),0) as _count
	FROM panel_cdr.monitor_services
    where NMB_WEBSERVICE = _webServices -- 'ModifyParty'
    and CDG_ERROR != 0
	group by CDG_ERROR, DSC_ERROR, NMB_WEBSERVICE, _fecha
	order by _fecha, _err_ws, _count
    
            
            