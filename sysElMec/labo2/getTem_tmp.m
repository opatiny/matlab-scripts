function Tem = getTem(ib)
    theta_a = Hc*la;
    theta_b = nb*ib;
    WmagPrime_der = polyval(p_W_der, alpha);
    psi_ba_der = polyval(p_psi_ba_der, alpha);
    psi_bb_der = polyval(p_psi_bb_der, alpha);
    
    lambda_aa_der = 2* WmagPrime_der/(Hc*la)^2;
    lambda_bb_der = psi_bb_der/(nb^2*ib);
    lambda_ab_der = psi_ba_der/(Hc*la*nb);
    
    Tem = 1/2*lambda_aa_der * theta_a^2 + 1/2*lambda_bb_der * theta_b^2 ...
        + 1/2*lambda_ab_der * theta_a * theta_b; 
end