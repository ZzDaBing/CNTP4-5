/******************************************/
/* tp2_poisson1D_direct.c                 */
/* This file contains the main function   */
/* to solve the Poisson 1D problem        */
/******************************************/
#include "lib_poisson1D.h"
int main(int argc,char *argv[])
/* ** argc: Number of arguments */
/* ** argv: Values of arguments */
{
  int ierr;
  int jj;
  int nbpoints, la; //?, dimension de A (=n)
  int ku, kl, kv, lab;  //nb_upper diag, nb_lower diag, vecteur de travail, dimension de AB
  int *ipiv;
  int info;
  int NRHS; //Nombre d'equation du second membre
  double T0, T1;  //Temperature aux extremites
  double *RHS, *EX_SOL, *X; //Second membre
  double *AB; //A sous forme General Band

  double temp, relres;

  NRHS=1;
  nbpoints=102;
  la=nbpoints-2;
  T0=-5.0;
  T1=5.0;



  printf("--------- Poisson 1D ---------\n\n");
  RHS=(double *) malloc(sizeof(double)*la);
  EX_SOL=(double *) malloc(sizeof(double)*la);
  X=(double *) malloc(sizeof(double)*la);

  set_grid_points_1D(X, &la);
  set_dense_RHS_DBC_1D(RHS,&la,&T0,&T1);
  set_analytical_solution_DBC_1D(EX_SOL, X, &la, &T0, &T1);
  
  write_vec(RHS, &la, "RHS.dat");
  write_vec(EX_SOL, &la, "EX_SOL.dat");
  write_vec(X, &la, "X_grid.dat");

  kv=1;
  ku=1;
  kl=1;
  lab=kv+kl+ku+1;

  AB = (double *) malloc(sizeof(double)*lab*la);

  info=0;

  /* working array for pivot used by LU Factorization */
  ipiv = (int *) calloc(la, sizeof(int));

  int row = 0; //

  if (row == 1){ // LAPACK_ROW_MAJOR
    set_GB_operator_rowMajor_poisson1D(AB, &lab, &la);
    
    info = LAPACKE_dgbsv(LAPACK_ROW_MAJOR,la, kl, ku, NRHS, AB, la, ipiv, RHS, NRHS);
  } 
  else { // LAPACK_COL_MAJOR
    set_GB_operator_colMajor_poisson1D(AB, &lab, &la, &kv);
    //write_GB_operator_colMajor_poisson1D(AB, &lab, &la, "AB_col.dat");

    info = LAPACKE_dgbsv(LAPACK_COL_MAJOR,la, kl, ku, NRHS, AB, lab, ipiv, RHS, la);  //Calcul de X
  }
  
  printf("\nINFO DGBSV = %d\n",info);

  write_xy(RHS, X, &la, "SOL.dat");

  /* Relative residual */
  temp = cblas_ddot(la, RHS, 1, RHS,1);
  temp = sqrt(temp);
  cblas_daxpy(la, -1.0, RHS, 1, EX_SOL, 1);
  relres = cblas_ddot(la, EX_SOL, 1, EX_SOL,1);
  relres = sqrt(relres);
  relres = relres / temp;

  printf("\nThe relative residual error is relres = %e\n\n",relres);

    if (row == 1){ // LAPACK_ROW_MAJOR
    set_GB_operator_rowMajor_poisson1D(AB, &lab, &la);
    //write_GB_operator_rowMajor_poisson1D(AB, &lab, &la, "AB_row.dat");
    
    cblas_dgbmv(CblasRowMajor,CblasNoTrans,la,la,1,1,1,AB,lab,X,1,1,RHS,1);  //(cblas_layout, cblas_transa, m, n, ml, mu, alpha, a, lda, x, incx, beta, y, incy)
  } 
  else { // LAPACK_COL_MAJOR
    cblas_dcopy(la,RHS,1,X,1);  //copie la valeur de RHS (valant x dans Ax=b) dans X

    kv=0;
    lab = 3;
    set_dense_RHS_DBC_1D(RHS,&la,&T0,&T1);  //Réinitialise RHS
    set_GB_operator_colMajor_poisson1D(AB, &lab, &la, &kv); //Réinitialise AB sans le vecteur de travail

    cblas_dgbmv(CblasRowMajor,CblasNoTrans,la,la,1,1,1,AB,lab,X,1,-1,RHS,1);  //(cblas_layout, cblas_transa, m, n, ml, mu, alpha, a, lda, x, incx, beta, y, incy)
  }

  // Norme de RHS = Ax-b
  for(int i=0; i<la*lab;i++)
    printf("%e ", RHS[i]);  //Affichage de RHS
  double norm_DGBMV = cblas_ddot(la, RHS, 1, RHS,1);
  norm_DGBMV = sqrt(norm_DGBMV);
  printf("\n\nNorm of DGBMV = %e\n",norm_DGBMV);





  //LU pour matrice tridiagonale
  if (row == 1){ // LAPACK_ROW_MAJOR
    set_GB_operator_rowMajor_poisson1D(AB, &lab, &la);
    //write_GB_operator_rowMajor_poisson1D(AB, &lab, &la, "AB_row.dat");
    
    //LAPACKE_dgbtrf(LAPACK_COL_MAJOR,la,la,kl,ku,AB,lab,ipiv);
  } 
  else { // LAPACK_COL_MAJOR
    kv=1;
    lab=kl+ku+kv+1;
    set_GB_operator_colMajor_poisson1D(AB,&lab,&la,&kv);
    LAPACKE_dgbtrf(LAPACK_COL_MAJOR,la,la,kl,ku,AB,lab,ipiv);
  }


  for(int i=0; i<la*lab;i++)
    printf("%e ", AB[i]);  //Affichage de AB

  free(RHS);
  free(EX_SOL);
  free(X);
  free(AB);
  free(ipiv);

  printf("\n\n--------- End -----------\n");
}
