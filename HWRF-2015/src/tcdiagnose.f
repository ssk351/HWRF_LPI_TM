!                         tcdiagnose_v1.5
!
! This program generates azimutially averaged structures of the TC.
! The TC centers are determined at each pressure level based on the GPH.
! V1.1 Additions: tangential and radial wind in the horizontal field
! V1.2 Additions: text file of the balanced temperature
! V1.3 Modification for hwrf_2011 (kb=40)
! V1.4 Modification for hwrf_2012
! V1.4.4 for domain d23 (composite domain)
! V1.5 Modification for kb as a variable
!
! Output(azimuthal averaged):
!     geopotential height
!     temperature
!     tangential wind
!     secondary circulation
!     total wind speed
!     inflow angle
!     gradient wind
!     hydrostatic temperature
!     humidity
!     Absolute angular momentum
! Output(horizontal field):
!     tangential wind
!     radial wind
!     asymmetric wind field
!
!                                               FEB 09 2013 In-Hyuk Kwon 
!-----------------------------------------------------------------------
      program tcdiagnose
!-----------------------------------------------------------------------
      integer,parameter :: mt=185,nt=100,nt1=nt-1
      real(kind=4),allocatable,dimension(:,:,:) :: hgt0,tmp0,ugrd0
      real(kind=4),allocatable,dimension(:,:,:) :: hgt,tmp,ugrd
      real(kind=4),allocatable,dimension(:,:,:) :: tcolc,tcoli
      real(kind=4),allocatable,dimension(:,:,:) :: tcolc0,tcoli0
      real(kind=4),allocatable,dimension(:,:,:) :: tcolr,tcols
      real(kind=4),allocatable,dimension(:,:,:) :: tcolr0,tcols0
      real(kind=4),allocatable,dimension(:,:,:) :: tcolw,tcolnd
      real(kind=4),allocatable,dimension(:,:,:) :: tcolw0,tcolnd0
      real(kind=4),allocatable,dimension(:,:,:) :: cice,clwmr,dzdt
      real(kind=4),allocatable,dimension(:,:,:) :: cice0,clwmr0,dzdt0
      real(kind=4),allocatable,dimension(:,:,:) :: grmr,rwmr,snmr
      real(kind=4),allocatable,dimension(:,:,:) :: grmr0,rwmr0,snmr0
      real(kind=4),allocatable,dimension(:,:,:) :: vgrd0,spfh0,vv0
      real(kind=4),allocatable,dimension(:,:,:) :: rh0
      real(kind=4),allocatable,dimension(:,:,:) :: vgrd,spfh,vv,rh
      real(kind=4),allocatable,dimension(:,:) :: pbl,pbl0
      real(kind=8),allocatable,dimension(:,:) :: pbl8
      real(kind=8),allocatable,dimension(:,:) :: hgt8,tmp8,ugrd8
      real(kind=8),allocatable,dimension(:,:) :: vgrd8,spfh8,vv8,rh8
      real(kind=8),allocatable,dimension(:,:) :: tcolc8,tcoli8
      real(kind=8),allocatable,dimension(:,:) :: tcolr8,tcols8
      real(kind=8),allocatable,dimension(:,:) :: tcolw8,tcolnd8
      real(kind=8),allocatable,dimension(:,:) :: cice8,clwmr8
      real(kind=8),allocatable,dimension(:,:) :: dzdt8,grmr8
      real(kind=8),allocatable,dimension(:,:) :: rwmr8,snmr8
      real(kind=8),allocatable,dimension(:,:) :: ugrax,vgrax
      real(kind=8),allocatable,dimension(:,:) :: xlon,ylat,plon,plat
      real(kind=8),allocatable,dimension(:,:,:) :: vari3d,povari
      real(kind=8),allocatable,dimension(:,:) :: axvari
      real(kind=4),allocatable,dimension(:,:) :: vtgr,vrgr
      real(kind=4),allocatable,dimension(:,:) :: uasym,vasym
      real(kind=4),allocatable,dimension(:,:) :: rork1,rork2
      real(kind=4),allocatable,dimension(:,:) :: hgtcr,thydro,qcr
      real(kind=4),allocatable,dimension(:) :: xl1d,yl1d
      real(kind=4),allocatable,dimension(:) :: elat,elon,plev
      real(kind=8),dimension(0:nt1,mt) :: upo8,vpo8
      real(kind=4),dimension(0:nt1,mt) :: vtpo,vrpo
      real(kind=8),dimension(mt) :: axhgt,axtmp,axspfh,grwnd,axvv,axpbl
      real(kind=8),dimension(mt) :: axrh
      real(kind=8),dimension(mt) :: axtcolc,axtcoli,axtcolr,axtcols
      real(kind=8),dimension(mt) :: axtcolw,axtcolnd,axcice,axclwmr
      real(kind=8),dimension(mt) :: axdzdt,axgrmr,axrwmr,axsnmr
      real(kind=4),dimension(mt) :: sork1,axvt,axvr,axws,axin
      real(kind=4),dimension(mt) :: hgtdax,hgtax
      real(kind=4),dimension(13) :: tmpc,wlat,wlon
      real(kind=8) :: cenx,ceny,dmt
      real(kind=4) :: clat,clon,slat,slon,dlat,dlon,dclat,dclon,dist,ang
      real(kind=4) :: pi,pi180,dang,angle,ntm,sum1,sum2,undef,adis
      real(kind=4) :: fc,Omega,gravi,r,envh
      real(kind=4) :: tmp1,dmin,sr
      real(kind=4) :: pl,tl,ql,qsat,hl
      real(kind=4),parameter :: pq0=379.90516
      real(kind=4),parameter :: a1 =0.608
      real(kind=4),parameter :: a2 =17.2693882
      real(kind=4),parameter :: a3 =273.16
      real(kind=4),parameter :: a4 =35.86
      integer :: ib,jb,kb
      integer :: i,ic,j,jiv,k,ik,m,n,ism,l200,me,mgra,mr
      integer :: k1,k2,k3,k4,ks,ke,kbot,klen,ktot
      namelist /idata/ clat,clon,slat,slon,dlat,dlon,ib,jb,kb
      namelist /pdata/ plev
! -----------------------------------------------
       dmt  = 3.D3           ! radius interval (total radius= mt*dmt)
       undef= 9.999E+20
       Omega = 7.292e-05
       gravi= 9.8
       pi   = 3.141592653589793238
       pi180= pi/180.
       dang = 360. /nt
       sr   = 0.22                          ! radius for the center searching
       me   = mt *0.9
       mgra = 500.D3 /dmt +1
       
       read(11,NML=idata)

      print*,'ib,jb,kb',ib,jb,kb
      allocate( hgt(ib,jb,kb),tmp(ib,jb,kb),ugrd(ib,jb,kb) )
      allocate( hgt0(ib,jb,kb),tmp0(ib,jb,kb),ugrd0(ib,jb,kb) )
      allocate( vgrd(ib,jb,kb),spfh(ib,jb,kb),vv(ib,jb,kb) )
      allocate( vgrd0(ib,jb,kb),spfh0(ib,jb,kb),vv0(ib,jb,kb) )
      allocate( rh(ib,jb,kb),rh0(ib,jb,kb) )
      allocate( tcolc(ib,jb,kb),tcoli(ib,jb,kb),tcolr(ib,jb,kb) )
      allocate( tcols(ib,jb,kb),tcolw(ib,jb,kb),tcolnd(ib,jb,kb) )
      allocate( cice(ib,jb,kb),clwmr(ib,jb,kb),dzdt(ib,jb,kb) )
      allocate( grmr(ib,jb,kb),rwmr(ib,jb,kb),snmr(ib,jb,kb) )
      allocate( tcolc8(ib,jb),tcoli8(ib,jb),tcolr8(ib,jb) )
      allocate( tcols8(ib,jb),tcolw8(ib,jb),tcolnd8(ib,jb) )
      allocate( cice8(ib,jb),clwmr8(ib,jb),dzdt8(ib,jb) )
      allocate( grmr8(ib,jb),rwmr8(ib,jb),snmr8(ib,jb) )
      allocate( pbl(ib,jb),pbl0(ib,jb),pbl8(ib,jb) )
      allocate( hgt8(ib,jb),tmp8(ib,jb),ugrd8(ib,jb) )
      allocate( vgrd8(ib,jb),spfh8(ib,jb),vv8(ib,jb),rh8(ib,jb) )
      allocate( ugrax(ib,jb),vgrax(ib,jb),uasym(ib,jb),vasym(ib,jb) )
      allocate( xlon(ib,jb),ylat(ib,jb),plon(ib,jb),plat(ib,jb) )
      allocate( rork1(ib,jb),rork2(ib,jb) )
      allocate( vtgr(ib,jb),vrgr(ib,jb) )
      allocate( xl1d(ib),yl1d(jb) )
      allocate( hgtcr(mt,kb),thydro(mt,kb),qcr(mt,kb) )
      allocate( elat(kb),elon(kb),plev(kb) )

       read(11,NML=pdata)
      print*,'plev',plev

      do i= 1,ib
         xl1d(i)  = slon +(i-1) *dlon
         xlon(i,:)= slon +(i-1) *dlon 
      enddo
      do j= 1,jb
         yl1d(j)  = slat +(j-1) *dlat 
         ylat(:,j)= slat +(j-1) *dlat 
      enddo

!     if(slon < 0.) slon=slon+360.
!     if(clon < 0.) clon=clon+360.

      dclon=xl1d(ib/2+1)
      dclat=yl1d(jb/2+1)

      print*,'slon,slat,dlon,dlat'
      print*, slon,slat,dlon,dlat
      print*,'Storm center',clon,clat
      print*,'domain center',dclon,dclat

!.. Level of 200 hPa

         k=5
      do while(plev(k) > 200.)
         k= k+1
      enddo
      if( (200.-plev(k)) < (plev(k-1)-200.) )then
         l200= k
      else
         l200= k-1
      endif
         print*,'l200,plev(l200)',l200,plev(l200)

! -------------------

       open(12,file='HGT.bin',recl=ib*jb*kb*4,
     &      form='unformatted',access='direct')
       open(13,file='TMP.bin',recl=ib*jb*kb*4,
     &      form='unformatted',access='direct')
       open(14,file='UGRD.bin',recl=ib*jb*kb*4,
     &      form='unformatted',access='direct')
       open(15,file='VGRD.bin',recl=ib*jb*kb*4,
     &      form='unformatted',access='direct')
       open(19,file='SPFH.bin',recl=ib*jb*kb*4,
     &      form='unformatted',access='direct')
       open(17,file='VVEL.bin',recl=ib*jb*kb*4,
     &      form='unformatted',access='direct')
       open(18,file='HPBL.bin',recl=ib*jb*4,
     &      form='unformatted',access='direct')
       open(16,file='RH.bin',recl=ib*jb*kb*4,
     &      form='unformatted',access='direct')
       open(20,file='pblaxis.bin',recl=mt*4,
     &      form='unformatted',access='direct')
       open(21,file='hgtaxis.bin',recl=mt*4,
     &      form='unformatted',access='direct')
       open(22,file='tmpaxis.bin',recl=mt*4,
     &      form='unformatted',access='direct')
       open(23,file='vtaxis.bin',recl=mt*4,
     &      form='unformatted',access='direct')
       open(24,file='vraxis.bin',recl=mt*4,
     &      form='unformatted',access='direct')
       open(25,file='wsaxis.bin',recl=mt*4,
     &      form='unformatted',access='direct')
       open(26,file='inaxis.bin',recl=mt*4,
     &      form='unformatted',access='direct')
       open(27,file='grwind.bin',recl=mt*4,
     &      form='unformatted',access='direct')
       open(28,file='thydro.bin',recl=mt*4,
     &      form='unformatted',access='direct')
       open(31,file='vtgrd.bin',recl=ib*jb*4,
     &      form='unformatted',access='direct')
       open(32,file='vrgrd.bin',recl=ib*jb*4,
     &      form='unformatted',access='direct')
       open(33,file='spfhaxis.bin',recl=mt*4,
     &      form='unformatted',access='direct')
       open(34,file='rhaxis.bin',recl=mt*4,
     &      form='unformatted',access='direct')
       open(35,file='vvaxis.bin',recl=mt*4,
     &      form='unformatted',access='direct')
       open(36,file='amaxis.bin',recl=mt*4,
     &      form='unformatted',access='direct')
       open(37,file='uasym.bin',recl=ib*jb*4,
     &      form='unformatted',access='direct')
       open(38,file='vasym.bin',recl=ib*jb*4,
     &      form='unformatted',access='direct')
       open(39,file='rh.bin',recl=ib*jb*4,
     &      form='unformatted',access='direct')
*       open(40,file='TCOLC.bin',recl=ib*jb*kb*4,
*     &      form='unformatted',access='direct') 
*       open(41,file='TCOLI.bin',recl=ib*jb*kb*4,
*     &      form='unformatted',access='direct')
*      open(42,file='TCOLR.bin',recl=ib*jb*kb*4,
*     &      form='unformatted',access='direct')
*       open(43,file='TCOLS.bin',recl=ib*jb*kb*4,
*     &      form='unformatted',access='direct')
*       open(44,file='TCOLW.bin',recl=ib*jb*kb*4,
*     &      form='unformatted',access='direct')     
*       open(45,file='TCOLND.bin',recl=ib*jb*kb*4,
*     &      form='unformatted',access='direct')
*       open(46,file='CICE.bin',recl=ib*jb*kb*4,
*     &      form='unformatted',access='direct')
*       open(47,file='CLWMR.bin',recl=ib*jb*kb*4,
*     &      form='unformatted',access='direct')
*       open(48,file='DZDT.bin',recl=ib*jb*kb*4,
*     &      form='unformatted',access='direct')
       open(49,file='GRMR.bin',recl=ib*jb*kb*4,
     &      form='unformatted',access='direct')
*       open(50,file='RWMR.bin',recl=ib*jb*kb*4,
*     &      form='unformatted',access='direct')
*       open(51,file='SNMR.bin',recl=ib*jb*kb*4,
*     &      form='unformatted',access='direct')
*       open(52,file='tcolcaxis.bin',recl=mt*4,
*     &      form='unformatted',access='direct')
*       open(53,file='tcoliaxis.bin',recl=mt*4,
*     &      form='unformatted',access='direct')
*       open(54,file='tcolraxis.bin',recl=mt*4,
*     &      form='unformatted',access='direct')
*       open(55,file='tcolsaxis.bin',recl=mt*4,
*     &      form='unformatted',access='direct')
*       open(56,file='tcolwaxis.bin',recl=mt*4,
*     &      form='unformatted',access='direct')
*       open(57,file='tcolndaxis.bin',recl=mt*4,
*     &      form='unformatted',access='direct')
*       open(58,file='ciceaxis.bin',recl=mt*4,
*     &      form='unformatted',access='direct')
*       open(59,file='clwmraxis.bin',recl=mt*4,
*     &      form='unformatted',access='direct')
*       open(60,file='dzdtaxis.bin',recl=mt*4,
*     &      form='unformatted',access='direct') 
       open(61,file='grmraxis.bin',recl=mt*4,
     &      form='unformatted',access='direct')
*       open(62,file='rwmraxis.bin',recl=mt*4,
*     &      form='unformatted',access='direct')
*       open(63,file='snmraxis.bin',recl=mt*4,
*     &      form='unformatted',access='direct')

      write(*,*) 'operation lat & lon: ',clat,clon

       read(12,rec=1) hgt0
       read(13,rec=1) tmp0
       read(14,rec=1) ugrd0
       read(15,rec=1) vgrd0
       read(16,rec=1) spfh0
       read(17,rec=1) vv0
       read(18,rec=1) pbl0
       read(19,rec=1) rh0
*       read(40,rec=1) tcolc0
*       read(41,rec=1) tcoli0
*       read(42,rec=1) tcolr0
*       read(43,rec=1) tcols0
*       read(44,rec=1) tcolw0
*       read(45,rec=1) tcolnd0
*       read(46,rec=1) cice0
*       read(47,rec=1) clwmr0
*       read(48,rec=1) dzdt0
       read(49,rec=1) grmr0
*       read(50,rec=1) rwmr0
*       read(51,rec=1) snmr0
       print*,'rh=',rh0(100,100,4)

       adis= sqrt( (dclat-clat)**2. +(dclon-clon)**2. )
      print*,'distance from the domain center to the storm center',adis

      if(adis > 2.7)then
         print*,'Storm center is far away from the domain center'
!         elat(:)= clat
!         elon(:)= clon
         elat(:)= dclat
         elon(:)= dclon
         goto 998
      endif

       do i=1,jb
        j=jb-i+1
        hgt(:,i,:)=hgt0(:,j,:)
        tmp(:,i,:)=tmp0(:,j,:)
        ugrd(:,i,:)=ugrd0(:,j,:)
        vgrd(:,i,:)=vgrd0(:,j,:)
        spfh(:,i,:)=spfh0(:,j,:)
        vv(:,i,:)=vv0(:,j,:)
        rh(:,i,:)=rh0(:,j,:)
        pbl(:,i)=pbl0(:,j)
*        tcolc(:,i,:)=tcolc0(:,j,:)
*        tcoli(:,i,:)=tcoli0(:,j,:)
*        tcolr(:,i,:)=tcolr0(:,j,:)
*        tcols(:,i,:)=tcols0(:,j,:)
*        tcolw(:,i,:)=tcolw0(:,j,:)
*        tcolnd(:,i,:)=tcolnd0(:,j,:)
*        cice(:,i,:)=cice0(:,j,:)
*        clwmr(:,i,:)=clwmr0(:,j,:)
*        dzdt(:,i,:)=dzdt0(:,j,:)
        grmr(:,i,:)=grmr0(:,j,:)
*        rwmr(:,i,:)=rwmr0(:,j,:)
*        snmr(:,i,:)=snmr0(:,j,:) 
      enddo

       k= 1
       rork1(:,:) = hgt(:,:,1)

      call findCenter
     &(rork1,xl1d,yl1d,clon,clat,elon(k),elat(k),ib,jb,sr,-1)

       adis= sqrt( (elat(k)-clat)**2. +(elon(k)-clon)**2. )

      write(*,*) k,'central lat & lon: ',elat(k),elon(k),adis

      if(adis > 0.4)then
         elon(:)= clon
         elat(:)= clat
         goto 998
      endif

      do k=2,l200

         rork1(:,:) = hgt(:,:,k)

        call findCenter
     & (rork1,xl1d,yl1d,elon(k-1),elat(k-1),elon(k),elat(k),ib,jb,sr,-1)

         adis= sqrt((elat(k)-elat(k-1))**2. +(elon(k)-elon(k-1))**2.)

        if(adis > 0.2)then
           elon(k)= elon(k-1)
           elat(k)= elat(k-1)
        endif

      write(*,*) k,'central lat & lon: ',elat(k),elon(k),adis

      enddo

      do k=l200+1,kb
         elat(k)= elat(l200)
         elon(k)= elon(l200)
      enddo

  998 continue
! ------------------- Stotm center

       open(71,file='stoCenter.txt')
      write(71,'(2F10.3)') elat(1),elon(1)
      close(71)
      write(*,*) 'stoCenter.txt printed'

! --------------
      do k=1,kb
! --------------
      write(*,*) 'k=',k

         hgt8(:,:) = hgt(:,:,k)
         tmp8(:,:) = tmp(:,:,k)
         ugrd8(:,:)= ugrd(:,:,k)
         vgrd8(:,:)= vgrd(:,:,k)
         spfh8(:,:)= spfh(:,:,k)
         rh8(:,:)  = rh(:,:,k)
         vv8(:,:)  = vv(:,:,k)
         pbl8(:,:) = pbl(:,:)
*         tcolc8(:,:) = tcolc(:,:,k)
*         tcoli8(:,:) = tcoli(:,:,k)
*         tcolr8(:,:) = tcolr(:,:,k)
*         tcols8(:,:) = tcols(:,:,k)
*         tcolw8(:,:) = tcolw(:,:,k)
*         tcolnd8(:,:) = tcolnd(:,:,k)
*         cice8(:,:) = cice(:,:,k)
*         clwmr8(:,:) = clwmr(:,:,k)
*         dzdt8(:,:) = dzdt(:,:,k)
         grmr8(:,:) = grmr(:,:,k)
*         rwmr8(:,:) = rwmr(:,:,k)
*         snmr8(:,:) = snmr(:,:,k)  
       cenx=elon(k)
       ceny=elat(k)
!        cenx=clon
!        ceny=clat

! ------------------------ Axisymmetric component of PBL

      call axisymmet
     &(pbl8,xlon,ylat,ib,jb,cenx,ceny,axpbl,mt,nt,dmt)

       do i= 1,mt
        if(axpbl(i) > 1.e10)then
            sork1(i)  = undef
        else
           sork1(i)  = axpbl(i)
       endif
      enddo
      write(20,rec=k) sork1

! ------------------------ Axisymmetric component of geopotential height

      call axisymmet
     &(hgt8,xlon,ylat,ib,jb,cenx,ceny,axhgt,mt,nt,dmt) 

      do i= 1,mt
        if(axhgt(i) > 1.e10)then
           hgtcr(i,k)= undef
           sork1(i)  = undef
        else
           hgtcr(i,k)= axhgt(i)
           sork1(i)  = axhgt(i)
        endif
      enddo
      write(21,rec=k) sork1

! ------------------------ Axisymmetric component of temperature

      call axisymmet
     &(tmp8,xlon,ylat,ib,jb,cenx,ceny,axtmp,mt,nt,dmt)

      do i= 1,mt
        if(axtmp(i) > 1.e10)then
           sork1(i)= undef
        else
           sork1(i)= axtmp(i)
        endif
      enddo
      write(22,rec=k) sork1

! --------------- Axisymmetric component of graupel mixing ratio

      call axisymmet
     &(grmr8,xlon,ylat,ib,jb,cenx,ceny,axgrmr,mt,nt,dmt)

      do i= 1,mt
        if(axgrmr(i) > 1.e10)then
           sork1(i)= undef
        else
           sork1(i)= axgrmr(i)
        endif
      enddo
      write(49,rec=k) sork1

! -------------------- Axisymmetric component of vertical velocity

      call axisymmet
     &(vv8,xlon,ylat,ib,jb,cenx,ceny,axvv,mt,nt,dmt)

      do i= 1,mt
        if(axvv(i) > 1.e10)then
           sork1(i)= undef
        else
           sork1(i)= axvv(i)
        endif
      enddo
      write(35,rec=k) sork1

! -------------------- Axisymmetric component of specific humidity

      call axisymmet
     &(spfh8,xlon,ylat,ib,jb,cenx,ceny,axspfh,mt,nt,dmt)

      do i= 1,mt
        if(axspfh(i) > 1.e10)then
!          qcr(i,k)= undef
           sork1(i)= undef
        else
!          qcr(i,k)= axspfh(i)
           sork1(i)= axspfh(i)
        endif
      enddo
      write(33,rec=k) sork1

! -------------------- Relative humidity

!         pl= plev(k) *1.e2
!      do i= 1,mt
!        if(axspfh(i) > 1.e10 .or. axtmp(i) > 1.e10)then
!           sork1(i)= undef
!        else
!           tl= axtmp(i)
!           ql= axspfh(i)
!           qsat= pq0/pl *exp(a2*(tl-a3)/(tl-a4))
!           hl= ql /qsat
!           sork1(i)= hl
!        endif
!      enddo

       call axisymmet
     &(rh8,xlon,ylat,ib,jb,cenx,ceny,axrh,mt,nt,dmt)

      do i= 1,mt
       if(axrh(i) > 1.e10)then
           sork1(i)= undef
       else
           sork1(i)= axrh(i)
       endif
      enddo

      write(34,rec=k) sork1

! ------------------- Tangential & radial wind

! --- Polar coordinate information of corresponding grid point
!     call polarinfo
!    &(xlon,ylat,ib,jb,cenx,ceny,plon,plat)

!                                             vtgr: tangential wind
!                                             vrgr: radial wind
!     do j=1,jb
!     do i=1,ib
!       if(ugrd8(i,j) > 1.e10 .or. vgrd8(i,j) > 1.e10)then
!          vtgr(i,j)= undef
!          vrgr(i,j)= undef
!       else
!          angle = plon(i,j) *pi180
!          vtgr(i,j)= -ugrd8(i,j)*sin(angle) +vgrd8(i,j)*cos(angle)
!          vrgr(i,j)=  ugrd8(i,j)*cos(angle) +vgrd8(i,j)*sin(angle)
!       endif
!     enddo
!     enddo

!     write(31,rec=k) vtgr
!     write(32,rec=k) vrgr

! ------------------- Axisymmetric component of tangential & radial wind


! --- Transform the field into polar coordinate
      call trans2Polar
     &(ugrd8,xlon,ylat,ib,jb,cenx,ceny,upo8,mt,nt,dmt) 
      call trans2Polar
     &(vgrd8,xlon,ylat,ib,jb,cenx,ceny,vpo8,mt,nt,dmt) 

!                                vtpo: tangential wind in polar coord.
!                                vrpo: radial wind in polar coord.
      do m= 1,mt
        do n= 0,nt1
          if(upo8(n,m) > 1.e10 .or. vpo8(n,m) > 1.e10)then
             vtpo(n,m)= undef           
             vrpo(n,m)= undef
          else
             angle = n *dang *pi180
             vtpo(n,m)= -upo8(n,m)*sin(angle) +vpo8(n,m)*cos(angle)
             vrpo(n,m)=  upo8(n,m)*cos(angle) +vpo8(n,m)*sin(angle)
          endif
        enddo
      enddo

         ntm= nt * 0.7  ! Minimum percentage of valid points for the azimuthal average

      do m= 1,mt
           sum1= 0.
           sum2= 0.
           ism= 0
        do n= 0,nt1
          if(vtpo(n,m) < 1.e10 .and. vrpo(n,m) < 1.e10)then
           ism= ism + 1
           sum1= sum1 + vtpo(n,m)
           sum2= sum2 + vrpo(n,m)
          endif
        enddo
          if(ism < ntm )then
            axvt(m)= undef
            axvr(m)= undef
            axws(m)= undef
            axin(m)= undef
          else
            axvt(m)= sum1 /ism
            axvr(m)= sum2 /ism
            axws(m)= sqrt(axvt(m)**2. +axvr(m)**2.) ! totalWind
            axin(m)= atan2(-axvr(m),axvt(m)) /pi180 ! inflowAngle
          endif
      enddo
      write(23,rec=k) axvt
      write(24,rec=k) axvr
      write(25,rec=k) axws
      write(26,rec=k) axin

! ------------------- Absolute angular momentum

         fc= 2.D0 *Omega *SIN(ceny*PI180)

      do m= 1,mt
         r= dmt *(m-1)
         tmp1= r*axvt(m) + fc*r*r/2.
        if(tmp1 > 1.e10)then
           sork1(m)= undef
        else
           sork1(m)= tmp1
        endif
      enddo
      write(36,rec=k) sork1

! ------------------- gradient wind

      call gradientw(axhgt,grwnd,mt,dmt,ceny)

           sork1(:)= undef
      do i= 1,mgra
        if(grwnd(i) < 1.e10)then
           sork1(i)= grwnd(i)
        endif
      enddo
      write(27,rec=k) sork1

! ------------------- asymetric wind field

!     if(k == 1)then
!          m =3
!       do while(axvt(m) > axvt(m-1))
!          m =m+1
!       enddo
!       do while(axvt(m) > 4.)
!          mr=m
!          m =m+1
!       enddo
!     print*,'mr=',mr
!     endif

!     do m =mr,mt
!        tmp1= exp( (7.*(m -mr)/mr )**2. *(-1.) )
!        axvt(m)= axvt(m) *tmp1
!        axvr(m)= axvr(m) *tmp1
!     enddo

!     do m =1,mt
!        vtpo(:,m)= axvt(m)
!        vrpo(:,m)= axvr(m)
!     enddo

!     do n= 0,nt1
!        angle= n *dang *pi180
!       do m= 1,mt
!          upo8(n,m)= -vtpo(n,m)*sin(angle) +vrpo(n,m)*cos(angle)
!          vpo8(n,m)=  vtpo(n,m)*cos(angle) +vrpo(n,m)*sin(angle)
!       enddo
!     enddo

!      ugrax(:,:)= 0.
!      vgrax(:,:)= 0.

!     call trans2Rect
!    &(ugrax,xlon,ylat,ib,jb,cenx,ceny,upo8,mt,nt,dmt)
!     call trans2Rect
!    &(vgrax,xlon,ylat,ib,jb,cenx,ceny,vpo8,mt,nt,dmt)

!      uasym= ugrd8 -ugrax
!      vasym= vgrd8 -vgrax

!     do j=1,jb
!     do i=1,ib
!        tmp1= sqrt( (xlon(i,j)-cenx)**2 +(ylat(i,j)-ceny)**2. )
!       if(tmp1 < dlat)then
!          uasym(i,j)= undef
!          vasym(i,j)= undef
!       endif
!     enddo
!     enddo

!     write(37,rec=k) uasym
!     write(38,rec=k) vasym

      if(cenx == elon(k+1) .and. ceny == elat(k+1))then
         kbot= k+1
         klen= kb -kbot +1
         goto 999
      endif

! --------------
      enddo
! --------------

  999 continue

      ktot= klen *4
      allocate( vari3d(ib,jb,ktot), axvari(mt,ktot) )

       ks=1
       ke=ks+klen-1
       vari3d(:,:,ks:ke)=hgt(:,:,kbot:kb)
       ks=ke+1
       ke=ks+klen-1
       vari3d(:,:,ks:ke)=tmp(:,:,kbot:kb)
       ks=ke+1
       ke=ks+klen-1
       vari3d(:,:,ks:ke)=vv(:,:,kbot:kb)
       ks=ke+1
       ke=ks+klen-1
       vari3d(:,:,ks:ke)=spfh(:,:,kbot:kb)

      call axisymmet_3D
     &(vari3d,xlon,ylat,ib,jb,ktot,cenx,ceny,axvari,mt,nt,dmt)

      deallocate( vari3d )

      ktot= klen *4
      allocate( vari3d(ib,jb,ktot), povari(0:nt1,mt,ktot) )

       ks=1
       ke=ks+klen-1
       vari3d(:,:,ks:ke)=ugrd(:,:,kbot:kb)
       ks=ke+1
       ke=ks+klen-1
       vari3d(:,:,ks:ke)=vgrd(:,:,kbot:kb)

      call trans2Polar_3D
     &(vari3d,xlon,ylat,ib,jb,ktot,cenx,ceny,povari,mt,nt,dmt)

      deallocate( vari3d )

! ----------------
      do k=1,klen
! ----------------
         k1=k
         k2=k+klen*1
         k3=k+klen*2
         k4=k+klen*3

      do i= 1,mt
        if(axvari(i,k1) > 1.e10)then
           hgtcr(i,k+kbot-1)=undef
           sork1(i)  = undef
        else
           hgtcr(i,k+kbot-1)=axvari(i,k1)
           sork1(i)  = axvari(i,k1)
        endif
      enddo
      write(21,rec=k+kbot-1) sork1

      call gradientw(axvari(:,k1),grwnd,mt,dmt,ceny)

           sork1(:)= undef
      do i= 1,mgra
        if(grwnd(i) < 1.e10)then
           sork1(i)= grwnd(i)
        endif
      enddo
      write(27,rec=k+kbot-1) sork1

      do i= 1,mt
        if(axvari(i,k2) > 1.e10)then
           sork1(i)= undef
        else
           sork1(i)= axvari(i,k2)
        endif
      enddo
      write(22,rec=k+kbot-1) sork1

      do i= 1,mt
        if(axvari(i,k3) > 1.e10)then
           sork1(i)= undef
        else
           sork1(i)= axvari(i,k3)
        endif
      enddo
      write(35,rec=k+kbot-1) sork1

      do i= 1,mt
        if(axvari(i,k4) > 1.e10)then
           sork1(i)= undef
        else
           sork1(i)= axvari(i,k4)
        endif
      enddo
      write(33,rec=k+kbot-1) sork1

         pl= plev(k+kbot-1) *1.e2
      do i= 1,mt
           tl= axvari(i,k2)
           ql= axvari(i,k4)
        if(tl > 1.e10 .or. ql > 1.e10)then
           sork1(i)= undef
        else
           qsat= pq0/pl *exp(a2*(tl-a3)/(tl-a4))
           hl= ql /qsat
           sork1(i)= hl
        endif
      enddo
      write(34,rec=k+kbot-1) sork1

      do m= 1,mt
        do n= 0,nt1
           upo8(n,m)= povari(n,m,k1)
           vpo8(n,m)= povari(n,m,k2)
          if(upo8(n,m) > 1.e10 .or. vpo8(n,m) > 1.e10)then
             vtpo(n,m)= undef
             vrpo(n,m)= undef
          else
             angle = n *dang *pi180
             vtpo(n,m)= -upo8(n,m)*sin(angle) +vpo8(n,m)*cos(angle)
             vrpo(n,m)=  upo8(n,m)*cos(angle) +vpo8(n,m)*sin(angle)
          endif
        enddo
      enddo

         ntm= nt * 0.7

      do m= 1,mt
           sum1= 0.
           sum2= 0.
           ism= 0
        do n= 0,nt1
          if(vtpo(n,m) < 1.e10 .and. vrpo(n,m) < 1.e10)then
           ism= ism + 1
           sum1= sum1 + vtpo(n,m)
           sum2= sum2 + vrpo(n,m)
          endif
        enddo
          if(ism < ntm )then
            axvt(m)= undef
            axvr(m)= undef
            axws(m)= undef
            axin(m)= undef
          else
            axvt(m)= sum1 /ism
            axvr(m)= sum2 /ism
            axws(m)= sqrt(axvt(m)**2. +axvr(m)**2.) ! totalWind
            axin(m)= atan2(-axvr(m),axvt(m)) /pi180 ! inflowAngle
          endif
      enddo
      write(23,rec=k+kbot-1) axvt
      write(24,rec=k+kbot-1) axvr
      write(25,rec=k+kbot-1) axws
      write(26,rec=k+kbot-1) axin

      do m= 1,mt
         r= dmt *(m-1)
         tmp1= r*axvt(m) + fc*r*r/2.
        if(tmp1 > 1.e10)then
           sork1(m)= undef
        else
           sork1(m)= tmp1
        endif
      enddo
      write(36,rec=k+kbot-1) sork1

! --------------
      enddo
! --------------

! ------------------- hydrostatic balanced temperature

! ..Virtual temperature from hydrostatic EQ

!     call hydrostat(hgtcr,thydro,mt,kb,plev)

      do k= 1,kb
        do i= 1,mt
!         if(thydro(i,k) > 1.e10)then
             sork1(i)= undef
!         else
!            sork1(i)= thydro(i,k) /( 1. +a1 *qcr(i,k) )
!         endif
        enddo
         write(28,rec=k) sork1
      enddo

! ---------------------   
! ------------------- 
      close(12)
      close(13)
      close(14)
      close(15)
      close(16)
      close(17) 
      close(18)
      close(20)
      close(21)
      close(22)
      close(23)
      close(24)
      close(25)
      close(26)
      close(27)
      close(28)
      close(31)
      close(32)
      close(49)
      print*, '== 3D field diagnosis is complete =='
!-----------------------------------------------------------------------
      end program tcdiagnose
!-----------------------------------------------------------------------