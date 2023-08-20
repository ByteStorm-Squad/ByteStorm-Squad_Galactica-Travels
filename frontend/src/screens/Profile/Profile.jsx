import React from "react";
import PageHeader from "../../components/PageHeader/PageHeader";
import { DetailCard, SkillCard,DonutChart} from "../../components/profile-components";
import userIcon from "../../images/user.png";
import bottommid from "../../images/profile/bottommid.png";
import bottomleft from "../../images/profile/bottomleft.png";
import bottomright from "../../images/profile/bottomright.png";
import topleft from "../../images/profile/topleft.png";
import topmid from "../../images/profile/topmid.png";
import topright from "../../images/profile/topright.png";

const Profile = ({userDetails,taskData,userImage}) => {

    const data = [
        ['Task', 'Percentage'],
        ['Adventure', 1],
        ['Combact', 20],
      ];
    
    const details = {
        id:'JD2000',
        galaxy:'SOL',
        planet:'Earth',
        gender : "Male",
        age : 24,
        name: 'John Doe'
    }
    return(
        <div>
            <PageHeader title={'Profile'}/>
            
            <img src={userIcon} style={{width:100,height:100,borderRadius:100,position:'absolute','zIndex': 1,top:385,left:145}}/>
            
            <img src={bottommid} style={{width:10,height:123,position:'absolute','zIndex': 1,top:500,left:200}}/>
            <img src={bottomleft} style={{width:62,height:100,position:'absolute','zIndex': 1,top:440,left:70}}/>
            <img src={bottomright} style={{width:65,height:76,position:'absolute','zIndex': 1,top:460,left:250}}/>

            <img src={topleft} style={{width:65,height:90,position:'absolute','zIndex': 1,top:330,left:70}}/>
            <img src={topmid} style={{width:10,height:130,position:'absolute','zIndex': 1,top:244,left:190}}/>
            <img src={topright} style={{width:65,height:78,position:'absolute','zIndex': 1,top:335,left:250}}/>

            <div style = {{marginTop:1}}>
            <div style={{display:'flex',flexDirection:'row',justifyContent:'center'}}>
                <DetailCard title={'InterGalactic ID'} detail={details.id} ishilighted={true}/>
            </div>
            <br></br>
            <div style={{display:'flex',flexDirection:'row',justifyContent:'center'}}>
                <DetailCard title={'Galaxy'} detail={details.galaxy} style={{'marginRight':60}}/>
                <DetailCard title={'Planet'} detail={details.planet} style={{'marginLeft':10}}/>
            </div>
            <div style={{display:'flex',flexDirection:'row',justifyContent:'center'}}>
               <DonutChart width={200} height={200} data = {data}/>
            </div>
            
            <div style={{display:'flex',flexDirection:'row',justifyContent:'center'}}>
                <DetailCard title={'Gender'} detail={details.gender} style={{'marginRight':40}}/>
                <DetailCard title={'Age'} detail={details.age} style={{'marginLeft':40}}/>
            </div>
            <br></br>
            <div style={{display:'flex',flexDirection:'row',justifyContent:'center'}}>
                <DetailCard title={'Gender'} detail={details.name}/>
            </div>
            </div>
            
           
            <div style={{display:'flex',flexDirection:'row',justifyContent:'center',marginTop:4}}>
                <SkillCard percentage={30} title={'Adventure'} color={'green'} style={{"marginLeft" : 10}}/>
                <SkillCard percentage={30} title={'Combat'} color={'red'}  style={{"marginLeft" : 10}}/>
            </div>
            
            
        </div>
    )
}

export default Profile;