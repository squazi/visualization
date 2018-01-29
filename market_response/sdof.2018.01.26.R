
# ... x(t) = x_h(t) + x_p(t) = Xo.exp(-zeta.w_n.t)*cos(w_d.t-phi_o) + X.cos(w.t-phi)
# ... To solve this, you find xp(0) and vp(0) and then find X0 and P0 such that the true initial conditions match x(0) and v(0).
# ... x_dot(t) = -Xo.zeta.w_n.exp(-zeta.w_n.t)*cos(w_d.t-phi_o) + Xo.w_d.exp(-zeta.w_n.t).sin(w_d.t-phi_o) + X.w.sin(w.t-phi)


csv_dir <- "/home/mcdevitt/_ds/_smu/_src/_processing/visualization/transient_response/market_response/data"
setwd(csv_dir)
dir()



eqty_files <- c(
    "BA.csv",
    "BABA.csv",
    "BRK-A.csv",
    "CSV.csv",
    "DJI.csv",
    "GE.csv",
    "MMM.csv",
    "SPY.csv")

eqty_beta = c(
    1.29,
    2.44,
    0.79,
    0.56,
    1.00,
    0.89,
    0.94,
    1.00)

csv_lst <- dir(pattern = ".csv$")
print(length(csv_lst))

for (eqty_num in 1:8)
{
csv_file <- eqty_files[eqty_num]

print(csv_file)

df_eqty <- read.csv(csv_file, sep = ",", stringsAsFactors = FALSE, header = TRUE)
names(df_eqty) <- tolower(names(df_eqty))

csv_indx_file <- "DJI.csv"
df_indx <- read.csv(csv_indx_file, sep = ",", stringsAsFactors = FALSE, header = TRUE)
names(df_indx) <- tolower(names(df_indx))

# ... static parameters

# ... each df_element

df_element <- data.frame(
              "sym"= character(0),
              "m" = numeric(0),
              "k" = numeric(0),
              "c" = numeric(0),
              "w_n" = numeric(0),
              "c_c" = numeric(0),
              "zeta" = numeric(0),
              "w_d" = numeric(0),
              stringsAsFactors = FALSE)
df_element_names <- names(df_element)

n_eqty <- 1
m <- 0
k <- 500
c <- eqty_beta[eqty_num]
w_n <- 0
c_c <- 0
zeta <- 0
w_d <- 0

new_element_row <- data.frame("AAA", m, k, c, w_n, c_c, zeta, w_d, stringsAsFactors = FALSE)
names(new_element_row) <- df_element_names
df_element <- rbind(df_element, new_element_row)

# ... forcing function

F_o <- 0.01
omega <- 0.1

# ... daily changing parameters
# ... - cycle thru each day
# ...   - update forcing function based on market volume (F_o, omega)
# ...   - each stock
# ...     - update parameters - mass --> w_n --> ... all remaining
# ...     - each time step

# ... daily update

mmm <- matrix(nrow = 1000, ncol = 255)

# ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# ...   loop on each day
# ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    for (iday in 1 : dim(df_eqty)[1])
    {
        date <- df_indx$date[iday]
        volume <- df_indx$volume[iday]
        
        omega <- volume / max(df_indx$volume) * 2

        eqty_close <- df_eqty$close[iday]
        mass <- log(eqty_close)
            
        w_n <- sqrt(k/mass)
        c_c <- 2 * mass * w_n
        zeta <- c / c_c
        w_d <- w_n * sqrt(1-zeta*zeta)
        r <- omega / w_n
        X <- F_o / sqrt((k - mass*omega*omega)*(k - mass*omega*omega) +
                                (c * omega) * (c * omega))
        phi <- atan2((k-m*omega*omega), c*omega)
        X_o <- F_o / k
        
        phi_o <- -acos(-X/X_o * cos(-phi))
        
        # ...   time loop parameters
        
        x_t <- as.numeric(list(10000))
        t <- as.numeric(list(10000))
        t_min <- 0.00
        del_t <- 0.1
        t_step <- 0
        
# ...   try to match starting point of new system with ending point of last
# ...   determine phi_o at t = (0-del_t) to equal x(t-del_t)
        
        if (iday > 1)
        {
            numer <- last_x - X * cos(-omega * del_t - phi)
            denom <- X_o * exp(zeta * w_n * del_t)
            expr <- numer / denom
            if (expr >  1) {expr =  1.0}
            if (expr < -1) {expr = -1.0}
            phi_o <- -acos(expr) + w_d * del_t
        }    

# ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# ...   loop on each time step
# ... -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

    for (it in 1 : 1000)
    {
            t[it] <- as.numeric(t_step)
                    
            x_t[it] <- X_o * exp(-zeta * w_n * t[it]) * cos(w_d * t[it] - phi_o) +
                    X * cos(omega * t[it] - phi)
                    
        t_step <- t_step + del_t
                    
    }   # ... foe loop on time step
        
    last_x <- x_t[it]
                
    plot(x_t ~ t, type = "l", col = 'darkblue', lwd = 2)
            
    mmm[, c(iday)] <- x_t

}   # ... for on iday

pts_file <- gsub("csv", "pts.csv", tolower(csv_file))
write.csv(mmm, pts_file, row.names = FALSE)

}


