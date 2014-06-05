/*
 Copyright (c) 2013 yvt
 
 This file is part of OpenSpades.
 
 OpenSpades is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 OpenSpades is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with OpenSpades.  If not, see <http://www.gnu.org/licenses/>.
 
 */

// (for range-based fog)
//   fogCoefficient = 1 / dist^2
//     where "dist" is the distance where objects disappear completely
//   useExponentalFog = false
//
// (for exponental (realistic) fog)
//   fogCoefficient = -1 / dist^2
//     where "dist" is the distance where fog density becomes 50%
//   useExponentalFog = true
uniform float fogCoefficient;
uniform bool useExponentalFog;

vec4 FogDensity(float poweredLength) {
	float distance = poweredLength;
	// FIMXE: use static branch for better performance
	if (useExponentalFog) {
		distance = 1. - exp2(distance * fogCoefficient);
	} else {
		distance = min(distance * fogCoefficient, 1.);
	}
	
	// tinted fog
	float weakenedDensity = 1. - distance;
	weakenedDensity *= weakenedDensity;
	return mix(vec4(distance), vec4(1. - weakenedDensity),
					 vec4(0., 0.3, 1.0, 0.0));
}
