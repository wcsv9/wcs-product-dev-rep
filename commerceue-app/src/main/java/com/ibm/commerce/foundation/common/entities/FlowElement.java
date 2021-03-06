//
// This file was generated by the JavaTM Architecture for XML Binding(JAXB) Reference Implementation, vJAXB 2.1.10 in JDK 6 
// See <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Any modifications to this file will be lost upon recompilation of the source schema. 
// Generated on: 2015.11.16 at 11:14:39 AM CST 
//


package com.ibm.commerce.foundation.common.entities;

import java.util.ArrayList;
import java.util.List;

import com.ibm.commerce.copyright.IBMCopyright;


/**
 * Flow elements could be path, condition, equation, branch, coordinator which function together to determine the flow.
 * 
 * <p>Java class for FlowElement complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="FlowElement">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="ElementIdentifier" type="{http://www.ibm.com/xmlns/prod/commerce/9/foundation}FlowElementIdentifier" minOccurs="0"/>
 *         &lt;element name="Description" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ParentElementIdentifier" type="{http://www.ibm.com/xmlns/prod/commerce/9/foundation}FlowElementIdentifier" minOccurs="0"/>
 *         &lt;element name="ElementSequence" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ElementAttribute" type="{http://www.ibm.com/xmlns/prod/commerce/9/foundation}FlowElementAttribute" maxOccurs="unbounded" minOccurs="0"/>
 *         &lt;element ref="{http://www.ibm.com/xmlns/prod/commerce/9/foundation}UserData" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
public class FlowElement {

	/**
	 * IBM copyright notice field.
	 */
	@SuppressWarnings("unused")
	private static final String COPYRIGHT = IBMCopyright.SHORT_COPYRIGHT;
	
    protected FlowElementIdentifier elementIdentifier;
    protected String description;
    protected FlowElementIdentifier parentElementIdentifier;
    protected String elementSequence;
    protected List<FlowElementAttribute> elementAttribute;
    protected UserData userData;

    /**
     * Gets the value of the elementIdentifier property.
     * 
     * @return
     *     possible object is
     *     {@link FlowElementIdentifier }
     *     
     */
    public FlowElementIdentifier getElementIdentifier() {
        return elementIdentifier;
    }

    /**
     * Sets the value of the elementIdentifier property.
     * 
     * @param value
     *     allowed object is
     *     {@link FlowElementIdentifier }
     *     
     */
    public void setElementIdentifier(FlowElementIdentifier value) {
        this.elementIdentifier = value;
    }

    /**
     * Gets the value of the description property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the value of the description property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDescription(String value) {
        this.description = value;
    }

    /**
     * Gets the value of the parentElementIdentifier property.
     * 
     * @return
     *     possible object is
     *     {@link FlowElementIdentifier }
     *     
     */
    public FlowElementIdentifier getParentElementIdentifier() {
        return parentElementIdentifier;
    }

    /**
     * Sets the value of the parentElementIdentifier property.
     * 
     * @param value
     *     allowed object is
     *     {@link FlowElementIdentifier }
     *     
     */
    public void setParentElementIdentifier(FlowElementIdentifier value) {
        this.parentElementIdentifier = value;
    }

    /**
     * Gets the value of the elementSequence property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getElementSequence() {
        return elementSequence;
    }

    /**
     * Sets the value of the elementSequence property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setElementSequence(String value) {
        this.elementSequence = value;
    }

    /**
     * Gets the value of the elementAttribute property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the elementAttribute property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getElementAttribute().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link FlowElementAttribute }
     * 
     * 
     */
    public List<FlowElementAttribute> getElementAttribute() {
        if (elementAttribute == null) {
            elementAttribute = new ArrayList<FlowElementAttribute>();
        }
        return this.elementAttribute;
    }

    /**
     * User Data.
     * 
     * @return
     *     possible object is
     *     {@link UserData }
     *     
     */
    public UserData getUserData() {
        return userData;
    }

    /**
     * Sets the value of the userData property.
     * 
     * @param value
     *     allowed object is
     *     {@link UserData }
     *     
     */
    public void setUserData(UserData value) {
        this.userData = value;
    }

}
