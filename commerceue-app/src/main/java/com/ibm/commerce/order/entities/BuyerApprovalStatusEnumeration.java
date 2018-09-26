//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 in JDK 6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2015.11.16 at 11:14:39 AM CST 
//


package com.ibm.commerce.order.entities;

import com.ibm.commerce.copyright.IBMCopyright;



/**
 * <p>Java class for BuyerApprovalStatusEnumeration.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p>
 * <pre>
 * &lt;simpleType name="BuyerApprovalStatusEnumeration">
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}normalizedString">
 *     &lt;enumeration value="Approved"/>
 *     &lt;enumeration value="Rejected"/>
 *     &lt;enumeration value="PendingApproval"/>
 *   &lt;/restriction>
 * &lt;/simpleType>
 * </pre>
 * 
 */
public enum BuyerApprovalStatusEnumeration {

    APPROVED("Approved"),
    REJECTED("Rejected"),
    PENDING_APPROVAL("PendingApproval");
    private final String value;

    /**
	 * IBM copyright notice field.
	 */
	@SuppressWarnings("unused")
	private static final String COPYRIGHT = IBMCopyright.SHORT_COPYRIGHT;
	
    BuyerApprovalStatusEnumeration(String v) {
        value = v;
    }

    public String value() {
        return value;
    }

    public static BuyerApprovalStatusEnumeration fromValue(String v) {
        for (BuyerApprovalStatusEnumeration c: BuyerApprovalStatusEnumeration.values()) {
            if (c.value.equals(v)) {
                return c;
            }
        }
        throw new IllegalArgumentException(v);
    }

}
