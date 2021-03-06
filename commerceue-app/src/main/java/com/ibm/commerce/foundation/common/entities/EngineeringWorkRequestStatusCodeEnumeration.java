//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 in JDK 6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2015.11.16 at 11:14:39 AM CST 
//


package com.ibm.commerce.foundation.common.entities;

import com.ibm.commerce.copyright.IBMCopyright;



/**
 * <p>Java class for EngineeringWorkRequestStatusCodeEnumeration.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p>
 * <pre>
 * &lt;simpleType name="EngineeringWorkRequestStatusCodeEnumeration">
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}normalizedString">
 *     &lt;enumeration value="inWork"/>
 *     &lt;enumeration value="issued"/>
 *   &lt;/restriction>
 * &lt;/simpleType>
 * </pre>
 * 
 */
public enum EngineeringWorkRequestStatusCodeEnumeration {

    IN_WORK("inWork"),
    ISSUED("issued");
    private final String value;
    
    /**
	 * IBM copyright notice field.
	 */
	@SuppressWarnings("unused")
	private static final String COPYRIGHT = IBMCopyright.SHORT_COPYRIGHT;
	
    EngineeringWorkRequestStatusCodeEnumeration(String v) {
        value = v;
    }

    public String value() {
        return value;
    }

    public static EngineeringWorkRequestStatusCodeEnumeration fromValue(String v) {
        for (EngineeringWorkRequestStatusCodeEnumeration c: EngineeringWorkRequestStatusCodeEnumeration.values()) {
            if (c.value.equals(v)) {
                return c;
            }
        }
        throw new IllegalArgumentException(v);
    }

}
