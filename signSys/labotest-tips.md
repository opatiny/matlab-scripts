# Tips for the labotest

## Useful matlab functions

| Function                | Description                                                                                       |
| ----------------------- | ------------------------------------------------------------------------------------------------- |
| `audioread('filename')` | Read audio file                                                                                   |
| `conv(xn, hn)`          | Convolution between 2 signals                                                                     |
| `filter(b,a,x)`         | Compute response of the filter described by vector coefficients `a` and `b` to a signal `x`       |
| `soundsc(xt,fe)`        | Play a signal `xt` with sampling frequency `fe`                                                   |
| `stem(tt, xt)`          | Plot a discrete signal                                                                            |
| `xcorr(x,y)`            | Correlation between `x` and `y`. Caution: it is `x` that is translated!! -> `rxy[k] = xcorr(y,x)` |

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
