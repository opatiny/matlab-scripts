# Tips for the labotest

## Useful matlab functions

| Function                            | Description                                                                                          |
| ----------------------------------- | ---------------------------------------------------------------------------------------------------- |
| `audioread('filename')`             | Read audio file                                                                                      |
| `bode(H,W)`                         | Compute the gains and phases of the filter `H` at the frequencies `W` (phase in degrees!!)           |
| `[num,den] = butter(order,fc/fnyq)` | Generate the coefficient of a Butterworth filter of order `order`                                    |
| `conv(xn, hn)`                      | Convolution between 2 signals                                                                        |
| `fft(xn)`                           | Fast Fourier transform of a signal for frequencies from o to $f_e$.                                  |
| `fftshift(fft(xn))`                 | Shifts the fast Fourier tranfrom to have it for frequencies from $-\frac{f_e}{2}$ to $\frac{f_e}{2}$ |
| `filter(b,a,x)`                     | Compute response of the filter described by vector coefficients `a` and `b` to a signal `x`          |
| `ifft(Xjf)`                         | Inverse fast Fourier transform                                                                       |
| `load('file.mat')`                  | Load a`.mat`file.                                                                                    |
| `pzmap(H)`                          | Plot poles and zeros of a filter                                                                     |
| `soundsc(xt,fe)`                    | Play a signal`xt`with sampling frequency`fe`                                                         |
| `stem(tt, xt)`                      | Plot a discrete signal                                                                               |
| `tf(num,den,Te)`                    | Generate transfer function from filter coefficients                                                  |
| `xcorr(x,y)`                        | Correlation between`x`and`y`. Caution: it is `x`that is translated!! ->`rxy[k] = xcorr(y,x)`         |

## Labo 1A

- Functions to generate various signals: `sie`, `sit`, `sir`, `sinam`
- Energy, power and rms of a signal: `ParamSignal`

## Labo 1B - Signal analysis

- Custom convolution function: `myconv`
- Gain of a lowpass filter equal to 1: divide `yx` by `sum(hn)` where `hn` is the impulse response of the filter
- Compute filter response to a signal using difference equation coefficients

## Labo 2: Cross-correlation

- Cross-correlation of x and y: it is y that is translated and x is not varied
- Autocorrelation: In $k=0$, we have the energy of the signal!!
- Link between correlation and convolution: $r_{xy} = x[-k] \ast y[k]$
- Caution with `xcorr(x,y)`: it is x that is translated  
  Example: `[rxy,lags]=xcorr(x,y)` -> `lags` is the vector with the values of k
- Custom correlation function: `customXcorr()`
- Ex4: extract sinusoidal signal from very noisy data

## Labo 4: Fourier series

- Decomposition of a periodic signal into it's Fourier series and synthesis (`computeFourierSeries` and `synthesisFourierSeries`)
- To synthetise a signal using matlab functions: `yt = filter(num, den, xt)`
- Compute power of signal from `Xjk`: `parsevalPower = sum(abs(Xjk).^2)`
- Ex2: Apply Butterworth filter to a signal and filter harmonics of a signal
- Use Bode to plot gain and amplitude of a filter at given frequencies
- Transform gain to dB: `A_dB = 20*log10(A)`

## Labo 5: Spectral analysis

- Ex1: Manually compute fast Fourier transform using a dot product
- The spectrum of a discrete signal is periodic, with the period equal to the sampling period.
- FT: to have have points where the spectrum is zero, the frequency step should be $\Delta f = \frac{1}{n\Delta t}$ where $n$ is a whole number
- `fft()` constraint: The number of points in the spectrum is equal to the nb of points in the signal.
- Filter a signal in the frequency domain by keeping only frequencies in the spectrum below the cutoff frequency.
- Reconstruct the signal: `xt_f = real(ifft(fftshift(Xjf_f * N)));`
- Ex 4: Remove noise from a signal by finding the harmonics and reconstructing the signal

  - Be careful to have a whole number of periods before the `fft`!!
  - Compute the `fft` of the signal
  - COmpute the unilateral spectrum
  - Find the peaks above threshold: `threshold = max(Ak)/2`
  - Reconstruct signal by summing harmonic function:
    ```m
    A0 = Ak(1);
    xrec = ones(1, length(xn))*A0;
    for i=1:length(APeaks)
    xrec = xrec + APeaks(i)*cos(2*pi*fPeaks(i)*tt+phiPeaks(i));
    end
    ```

- Ex4: Other example on how to apply a filter to a signal
