package com.module.xml;

import com.module.model.entity.*;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import java.util.LinkedList;
import java.util.List;

@XmlRootElement
public class VeteransExchange {

//    Veterans
    private List<VeteranEntity> veterans = new LinkedList<>();
    public List<VeteranEntity> getVeterans() {
        return veterans;
    }

    @XmlElement
    public void setVeterans(List<VeteranEntity> veterans) {
        this.veterans = veterans;
    }

//    WoundTypes
    private List<WoundTypeEntity> woundTypes = new LinkedList<>();
    public List<WoundTypeEntity> getWoundTypes() {
        return woundTypes;
    }

    @XmlElement
    public void setWoundTypes(List<WoundTypeEntity> woundTypes) {
        this.woundTypes = woundTypes;
    }

//    Honors
    private List<HonorEntity> honors = new LinkedList<>();
    public List<HonorEntity> getHonors() {
        return honors;
    }
    @XmlElement
    public void setHonors(List<HonorEntity> honors) {
        this.honors = honors;
    }

//    WoundDisabilities
    private List<WoundDisabilityEntity> woundDisabilities = new LinkedList<>();
    public List<WoundDisabilityEntity> getWoundDisabilities() {
        return woundDisabilities;
    }

    @XmlElement
    public void setWoundDisabilities(List<WoundDisabilityEntity> woundDisabilities) {
        this.woundDisabilities = woundDisabilities;
    }

//    Rank
    private List<RankEntity> ranks = new LinkedList<>();
    public List<RankEntity> getRanks() {
        return ranks;
    }

    @XmlElement
    public void setRanks(List<RankEntity> ranks) {
        this.ranks = ranks;
    }
}
