//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, v2.2.8-b130911.1802 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2016.07.21 at 02:34:02 PM CST 
//


package com.ibm.commerce.member.entities;
/*
 *-----------------------------------------------------------------
 * IBM Confidential
 *
 * OCO Source Materials
 *
 * WebSphere Commerce
 *
 * (C) Copyright IBM Corp. 2015, 2016
 *
 * The source code for this program is not published or otherwise
 * divested of its trade secrets, irrespective of what has
 * been deposited with the U.S. Copyright Office.
 *-----------------------------------------------------------------
 */
import javax.xml.bind.annotation.XmlEnum;

import com.ibm.commerce.copyright.IBMCopyright;


/**
 * <p>Java class for PreferredCommunicationEnumeration.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p>
 * <pre>
 * &lt;simpleType name="PreferredCommunicationEnumeration">
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}normalizedString">
 *     &lt;enumeration value="Telephone1"/>
 *     &lt;enumeration value="Telephone2"/>
 *     &lt;enumeration value="Email1"/>
 *     &lt;enumeration value="Email2"/>
 *     &lt;enumeration value="Fax1"/>
 *     &lt;enumeration value="Fax2"/>
 *   &lt;/restriction>
 * &lt;/simpleType>
 * </pre>
 * 
 */
@XmlEnum
public enum PreferredCommunicationEnumeration {
    TELEPHONE_1("Telephone1"),
    TELEPHONE_2("Telephone2"),
    EMAIL_1("Email1"),
    EMAIL_2("Email2"),
    FAX_1("Fax1"),
    FAX_2("Fax2");
    
	/**
	 * IBM copyright notice field.
	 */
	@SuppressWarnings("unused")
	private static final String COPYRIGHT = IBMCopyright.SHORT_COPYRIGHT;
	
    private final String value;

    PreferredCommunicationEnumeration(String v) {
        value = v;
    }

    public String value() {
        return value;
    }

    public static PreferredCommunicationEnumeration fromValue(String v) {
        for (PreferredCommunicationEnumeration c: PreferredCommunicationEnumeration.values()) {
            if (c.value.equals(v)) {
                return c;
            }
        }
        throw new IllegalArgumentException(v);
    }

}
