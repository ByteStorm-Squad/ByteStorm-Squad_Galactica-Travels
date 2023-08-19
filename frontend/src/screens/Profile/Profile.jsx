import React from "react";
import PageHeader from "../../components/PageHeader/PageHeader";
import { DetailCard, SkillCard,DonutChart,DonutChart} from "../../components/profile-components";


const Profile = ({userDetails,taskData}) => {

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
                <DetailCard title={'Age'} detail={details.age} style={{'marginLeft':10}}/>
            </div>
            <br></br>
            <div style={{display:'flex',flexDirection:'row',justifyContent:'center'}}>
                <DetailCard title={'Gender'} detail={details.name}/>
            </div>
            <br></br>
            <div style={{display:'flex',flexDirection:'row',justifyContent:'center'}}>
                <SkillCard percentage={30} title={'Adventure'} color={'green'} style={{"marginLeft" : 10}}/>
                <SkillCard percentage={30} title={'Combat'} color={'red'}  style={{"marginLeft" : 10}}/>
            </div>
            
            
        </div>
    )
}

export default Profile;