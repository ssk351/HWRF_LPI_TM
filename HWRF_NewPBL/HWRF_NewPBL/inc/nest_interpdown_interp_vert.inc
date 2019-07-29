!STARTOFREGISTRYGENERATEDINCLUDE 'inc/nest_interpdown_interp_vert.inc'
!
! WARNING This file is generated automatically by use_registry
! using the data base in the file named Registry.
! Do not edit.  Your changes to this file will be lost.
!
IF ( SIZE( grid%t, 1 ) * SIZE( grid%t, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  grid%t, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%q, 1 ) * SIZE( grid%q, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  grid%q, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%u, 1 ) * SIZE( grid%u, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  grid%u, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%v, 1 ) * SIZE( grid%v, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  grid%v, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%q2, 1 ) * SIZE( grid%q2, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  grid%q2, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%t_adj, 1 ) * SIZE( grid%t_adj, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  grid%t_adj, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%refl_10cm, 1 ) * SIZE( grid%refl_10cm, 3 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  grid%refl_10cm, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%cwm, 1 ) * SIZE( grid%cwm, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  grid%cwm, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%f_ice, 1 ) * SIZE( grid%f_ice, 3 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  grid%f_ice, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%f_rain, 1 ) * SIZE( grid%f_rain, 3 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  grid%f_rain, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%f_rimef, 1 ) * SIZE( grid%f_rimef, 3 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  grid%f_rimef, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%dwdt, 1 ) * SIZE( grid%dwdt, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  grid%dwdt, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%pint, 1 ) * SIZE( grid%pint, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting_w( &
                                  grid%pint, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  alt_w_c, alt_w_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%w, 1 ) * SIZE( grid%w, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting_w( &
                                  grid%w, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  alt_w_c, alt_w_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%w_tot, 1 ) * SIZE( grid%w_tot, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting_w( &
                                  grid%w_tot, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  alt_w_c, alt_w_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%z, 1 ) * SIZE( grid%z, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting_w( &
                                  grid%z, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  alt_w_c, alt_w_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%rlwtt, 1 ) * SIZE( grid%rlwtt, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  grid%rlwtt, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%rswtt, 1 ) * SIZE( grid%rswtt, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  grid%rswtt, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%winfo, 1 ) * SIZE( grid%winfo, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting_w( &
                                  grid%winfo, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  alt_w_c, alt_w_n ) !coordinates for parent and nest
ENDIF
IF ( SIZE( grid%iinfo, 1 ) * SIZE( grid%iinfo, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting_w( &
                                  grid%iinfo, & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  alt_w_c, alt_w_n ) !coordinates for parent and nest
ENDIF
DO itrace = PARAM_FIRST_SCALAR, num_moist
IF ( SIZE( moist, 1 ) * SIZE( moist, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  moist(grid%sm31,grid%sm32,grid%sm33,itrace), & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
ENDDO
DO itrace = PARAM_FIRST_SCALAR, num_scalar
IF ( SIZE( scalar, 1 ) * SIZE( scalar, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  scalar(grid%sm31,grid%sm32,grid%sm33,itrace), & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
ENDDO
DO itrace = PARAM_FIRST_SCALAR, num_dfi_scalar
IF ( SIZE( dfi_scalar, 1 ) * SIZE( dfi_scalar, 2 ) .GT. 1 ) THEN 
    CALL vert_interp_vert_nesting( &
                                  dfi_scalar(grid%sm31,grid%sm32,grid%sm33,itrace), & !CD field
                                  ids, ide, kds, kde, jds, jde, & !CD dims
                                  ims, ime, kms, kme, jms, jme, & !CD dims
                                  ips, ipe, kps, MIN( (kde-1), kpe ), jps, jpe, & !CD dims
                                  pgrid%s_vert, pgrid%e_vert, & !vertical dimension of the parent grid
                                  pgrid%cf1, pgrid%cf2, pgrid%cf3, pgrid%cfn, pgrid%cfn1, & !coarse grid extrapolation constants
                                  alt_u_c, alt_u_n ) !coordinates for parent and nest
ENDIF
ENDDO
!ENDOFREGISTRYGENERATEDINCLUDE